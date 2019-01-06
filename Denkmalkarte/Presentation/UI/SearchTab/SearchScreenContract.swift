import Foundation

protocol SearchScreenViewProtocol: View {
    var presenter: SearchScreenPresenterProtocol? { get set }
}

protocol SearchScreenPresenterProtocol: Presenter {
    var router: SearchTabRouter { get }
    var view: SearchScreenViewProtocol { get }

    func showDetailView(_ denkmal: Denkmal?)

    func search(query: String,
                success: @escaping (([Denkmal]) -> Void),
                failure: @escaping ((Error) -> Void))

}
