import UIKit

enum SearchScope: Int, CustomStringConvertible, CaseIterable {

    case title = 0
    case text
    case bauherr
    case ort

    var description: String {
        switch self {
        case .title: return "Title"
        case .text: return "Text"
        case .bauherr: return "Bauherr"
        case .ort: return "Ort"
        }
    }

}

public class SearchScreenView: UIViewController, UISearchBarDelegate, SearchScreenViewProtocol {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultsCountView: UILabel!

    var presenter: SearchScreenPresenterProtocol?
    
    private var results: [Denkmal] = []

    var scope: SearchScope = .title {
        didSet {
            performQuery()
        }
    }

    public override func viewDidLoad() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: DenkmalCell.identifier, bundle: Bundle(for: DenkmalCell.self)), forCellReuseIdentifier: DenkmalCell.identifier)
        setupNavigationBar()
        setupScopes()
    }

    private func setupNavigationBar() {
        title = "Search"
    }

    private func setupScopes() {
        let titles = SearchScope.allCases.map { $0.description }
        searchBar.scopeButtonTitles = titles
    }

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        performQuery()
    }

    private func performQuery() {
        if let query = searchBar.text {
            presenter?.search(query: query,
                              option: scope.description.lowercased(),
                              success: { result in
                                self.showSearchResult(result)
            }, failure: { _ in
            })
        }
    }

    private func showSearchResult(_ result: [Denkmal]) {
        self.results = result
        self.resultsCountView.text = "\(result.count) results"
        self.tableView.reloadData()
    }

}

// MARK: UITableViewDelegate

extension SearchScreenView: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DenkmalCell.identifier, for: indexPath) as? DenkmalCell
        let denkmal = results[indexPath.row]

        cell?.set(denkmal: denkmal)
        return cell!
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.tableView {
            // show/hide Keyboard
            searchBar.resignFirstResponder()
        }
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //code to execute on click
        let denkmal = results[indexPath.row]
        presenter?.showDetailView(denkmal)
    }

    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        scope = SearchScope(rawValue: selectedScope) ?? SearchScope.title
    }

}
