import Foundation

protocol Assembler {
    func resolve() -> MapUseCases
}

class AppAssembler: Assembler {

    func resolve() -> MapUseCases {
        return MapInteractor(dbHelper: DbHelperImpl(), apiHelper: ApiHelperImpl())
    }

}
