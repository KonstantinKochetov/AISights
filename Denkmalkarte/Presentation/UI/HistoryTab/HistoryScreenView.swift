import UIKit

public class HistoryScreenView: UIViewController, HistoryScreenViewProtocol, UISearchBarDelegate {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: HistoryScreenPresenterProtocol?

    private var results: [Denkmal] = []
    var option: String = "markiert"

    public override func viewDidLoad() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView();
        tableView.register(UINib(nibName: DenkmalCell.identifier, bundle: Bundle(for: DenkmalCell.self)), forCellReuseIdentifier: DenkmalCell.identifier)


        presenter?.search(query: true,
                          option: option,
                          success: { result in
                            self.showSearchResult(result)
        }, failure: { _ in
        })
    }


    // MARK: UISearchBarDelegate
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let query = searchBar.text {
            presenter?.search(query: query,
                              option: option,
                              success: { result in
                                self.showSearchResult(result)
            }, failure: { _ in
            })
        }
    }


    private func showSearchResult(_ result: [Denkmal]) {
        self.results = result
        self.container.isHidden = false
        self.tableView.reloadData()
    }
}


// MARK: UITableViewDelegate
extension HistoryScreenView: UITableViewDelegate, UITableViewDataSource {
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
}
