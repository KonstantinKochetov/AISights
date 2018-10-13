import Foundation

protocol DetailScreenViewProtocol: View {
    var presenter: DetailScreenPresenterProtocol? { get set }
}

protocol DetailScreenPresenterProtocol: Presenter {
    var router: SharedDetailRouter { get set }
    var view: DetailScreenViewProtocol? { get set }

}
