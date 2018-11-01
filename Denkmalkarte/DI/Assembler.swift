import Foundation

protocol Assembler {
    func resolve() -> MapUseCases
    func resolve() -> DbHelper
    func resolve() -> ApiHelper
}

class AppAssembler: Assembler {

    let dbHelper: DbHelper? = nil
    let apiHelper: ApiHelper? = nil
    let mapUseCases: MapUseCases? = nil

    func resolve() -> MapUseCases {
        if let mapUseCases = mapUseCases {
            return mapUseCases
        } else {
            return MapInteractor(dbHelper: self.resolve(), apiHelper: self.resolve())
        }
    }

    func resolve() -> DbHelper {
        if let dbHelper = dbHelper {
            return dbHelper
        } else {
            return DbHelperImpl()
        }
    }

    func resolve() -> ApiHelper {
        if let apiHelper = apiHelper {
            return apiHelper
        } else {
            return ApiHelperImpl()
        }
    }

}
