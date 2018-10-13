import Foundation

protocol HistoryScreenViewProtocol: View {
    var presenter: HistoryScreenPresenterProtocol? { get set }
}

protocol HistoryScreenPresenterProtocol: Presenter {
    var router: HistoryTabRouter { get }
    var view: HistoryScreenViewProtocol { get }

}
