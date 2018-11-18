import Foundation

protocol SearchScreenViewProtocol: View {
    var presenter: SearchScreenPresenterProtocol? { get set }
}

protocol SearchScreenPresenterProtocol: Presenter {
    var router: SearchTabRouter { get }
    var view: SearchScreenViewProtocol { get }

    func showDetailView(_ withId: [Int])
    func search(query: String,
                success: @escaping (([String]) -> Void),
                progress: @escaping ((Double) -> Void),
                failure: @escaping ((Swift.Error) -> Void))

}
