import Foundation

protocol Assembler {
    func resolve() -> MapUseCases
    func resolve() -> DbHelper
    func resolve() -> ApiHelper
     func resolve() -> Parser
}

class AppAssembler: Assembler {

    let dbHelper: DbHelper? = nil
    let apiHelper: ApiHelper? = nil
    let mapUseCases: MapUseCases? = nil

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

    func resolve() -> ApiHelper {
        if let apiHelper = apiHelper {
            return apiHelper
        } else {
            return ApiHelperImpl()
        }
    }
    
    func resolve() -> Parser {
        return Parser()
    }

}
