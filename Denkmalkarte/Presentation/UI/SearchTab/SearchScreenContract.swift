import Foundation

protocol SearchScreenViewProtocol: View {
    var presenter: SearchScreenPresenterProtocol? { get set }
}

protocol SearchScreenPresenterProtocol: Presenter {
    var router: SearchTabRouter { get }
    var view: SearchScreenViewProtocol { get }

    func showDetailView()

}
