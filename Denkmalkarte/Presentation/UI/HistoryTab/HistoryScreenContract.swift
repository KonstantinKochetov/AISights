import Foundation

protocol HistoryScreenViewProtocol: View {
    var presenter: HistoryScreenPresenterProtocol? { get set }
}

protocol HistoryScreenPresenterProtocol: Presenter {
    var router: HistoryTabRouter { get }
    var view: HistoryScreenViewProtocol { get }
    
    func showDetailView(_ denkmal: Denkmal?)

    func search(query: Bool, option: String, success: @escaping ([Denkmal]) -> Void, failure: @escaping (Error) -> Void)

    func search(query: String, option: String, success: @escaping ([Denkmal]) -> Void, failure: @escaping (Error) -> Void)
}
