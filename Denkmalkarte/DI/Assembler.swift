import Foundation
import FirebaseDatabase

protocol Assembler {
    func resolve() -> MapUseCases
    func resolve() -> DbHelper
    func resolve() -> ApiHelper
    func resolve() -> DatabaseReference
    func resolve() -> Parser
}

class AppAssembler: Assembler {

    let dbHelper: DbHelper? = nil
    let apiHelper: ApiHelper? = nil
    let mapUseCases: MapUseCases? = nil
    let ref: DatabaseReference? = nil

    func resolve() -> MapUseCases {
        if let mapUseCases = mapUseCases {
            return mapUseCases
        } else {
            return MapInteractor(dbHelper: self.resolve(), apiHelper: self.resolve(), parser: resolve())
        }
    }

    func resolve() -> DbHelper {
        if let dbHelper = dbHelper {
            return dbHelper
        } else {
            return DbHelperImpl(realmConfig: RealmHelper.config())
        }
    }

    func resolve() -> DatabaseReference {
        if let ref = ref {
            return ref
        } else {
            return Database.database().reference()
        }
    }

    func resolve() -> ApiHelper {
        if let apiHelper = apiHelper {
            return apiHelper
        } else {
            return ApiHelperImpl(ref: self.resolve())
        }
    }

    func resolve() -> Parser {
        return Parser()
    }
}
