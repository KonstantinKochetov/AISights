import Foundation

protocol InfoScreenViewProtocol: View {

    var presenter: InfoScreenPresenterProtocol? { get set }
}

protocol InfoScreenPresenterProtocol: Presenter {
    var router: InfoTabRouter { get }
    var view: InfoScreenViewProtocol { get }

}
