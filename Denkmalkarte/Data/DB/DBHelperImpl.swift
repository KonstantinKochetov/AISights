import Foundation
import MapKit
import RealmSwift

class DbHelperImpl: DbHelper {

    private var realmConfig: Realm.Configuration

    public init(realmConfig: Realm.Configuration? = nil) {
        self.realmConfig = realmConfig ?? RealmHelper.config()
    }

    func save(_ denkmal: Denkmal) throws {
        let realm = try self.realm()
        if realm.object(ofType: RealmDenkmal.self, forPrimaryKey: denkmal.id) == nil {
            try realm.write {
                realm.add(denkmal.toRealmDenkmal())
            }
        }
    }

    func saveAll(_ denkmale: [Denkmal]) throws {
        let realm = try self.realm()
        for denkmal in denkmale {
            if realm.object(ofType: RealmDenkmal.self, forPrimaryKey: denkmal.id) == nil {
                try realm.write {
                    realm.add(denkmal.toRealmDenkmal())
                }
            }
        }
    }

    func getAll() throws -> [Denkmal] {
        return Array(try self.realm().objects(RealmDenkmal.self)).map({$0.toDenkmal()})
    }

    func clean() throws {
        let realm = try self.realm()
        try realm.write {
            realm.delete(realm.objects(RealmDenkmal.self))
        }
    }

    private func realm() throws -> Realm {
        return try Realm(configuration: realmConfig)
    }

    func getDenkmale(success: @escaping ([Denkmal]) -> Void,
                     failure: @escaping (Error) -> Void) {
        do {
            let denkmale = try getAll()
            success(denkmale)
        } catch {
            failure(NSError(domain: "no domain", code: 406, userInfo: nil))
        }
    }

    func alreadyLoaded() -> Bool {
        return UserDefaults.standard.bool(forKey: "alreadyLoaded")
    }

    func setAlreadyLoaded() {
        UserDefaults.standard.set(true, forKey: "alreadyLoaded")
    }

    func getUserId() -> String {
         return UserDefaults.standard.string(forKey: "userIdIsCreated") ?? ""
    }

    func createUserId() {
        UserDefaults.standard.set(UUID().uuidString, forKey: "userIdIsCreated")
    }

    func search(query: String, option: String, success: @escaping ([Denkmal]) -> Void, failure: @escaping (Error) -> Void) {
        do {
            var finalDenkmale: [Denkmal] = []
            switch option {
            case "strasse":
                let denkmale1 = Array(try self.realm().objects(RealmDenkmal.self)).map({$0.toDenkmal()})
                let denkmale2 = denkmale1.filter { !$0.strasse.isEmpty }
                finalDenkmale = denkmale2.filter { $0.strasse[0].contains(query) }
            case "bauherr":
                let denkmale1 = Array(try self.realm().objects(RealmDenkmal.self)).map({$0.toDenkmal()})
                let denkmale2 = denkmale1.filter { !$0.bauherr.isEmpty }
                finalDenkmale = denkmale2.filter { $0.bauherr[0].contains(query) }
            case "datierung":
                let denkmale1 = Array(try self.realm().objects(RealmDenkmal.self)).map({$0.toDenkmal()})
                let denkmale2 = denkmale1.filter { !$0.datierung.isEmpty }
                finalDenkmale = denkmale2.filter { $0.datierung[0].contains(query) }
            default:
                let predicate = NSPredicate(format: "\(option) CONTAINS '\(query)'")
                finalDenkmale = Array(try self.realm().objects(RealmDenkmal.self).filter(predicate)).map({$0.toDenkmal()})
            }
               success(finalDenkmale)
        } catch {
            failure(NSError(domain: "no domain", code: 406, userInfo: nil))
        }
    }

    func bookmark(id: String,
                  success: @escaping (() -> Void),
                  failure: @escaping ((Error) -> Void)) {
        do {
            let predicate = NSPredicate(format: "id = '\(id)'")
            let denkmal = try self.realm().objects(RealmDenkmal.self).filter(predicate).first
            if let denkmal = denkmal {
                try realm().write {
                    if denkmal.markiert == false {
                        denkmal.setValue(true, forKey: "markiert")
                    } else {
                        denkmal.setValue(false, forKey: "markiert")
                    }
                }
            }
        } catch {
            failure(NSError(domain: "no domain", code: 406, userInfo: nil))
        }

    }
}
