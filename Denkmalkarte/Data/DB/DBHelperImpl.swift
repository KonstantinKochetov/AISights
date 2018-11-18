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
}

// TODO we need someone to fix parsing (they should be optionals, images and other split in arrays and so on so by the end it will be arrays and not long string) and all attributes including desription and big file and syncronously not temp file AND https + we need tester/swiftliner,
// cocoapods white file
// Beware the multiload of realm
// use simsim
// for me doing scaling
