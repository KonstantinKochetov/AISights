import UIKit

public class SearchScreenView: UIViewController, UISearchBarDelegate, SearchScreenViewProtocol {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var resultsCountView: UILabel!
    
    var presenter: SearchScreenPresenterProtocol?
    
    private var results: [String] = []
    
    public override func viewDidLoad() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: SearchResultCell.identifier, bundle: Bundle(for: SearchResultCell.self)), forCellReuseIdentifier: SearchResultCell.identifier)
        
    }
    
    
    // MARK: UISearchBarDelegate
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            presenter?.search(query: query,
            success: { result in
                self.results = result
                self.container.isHidden = false
                self.resultsCountView.text = "\(result.count) results"
                self.tableView.reloadData()
                
            }, progress: { percent in
                
            }, failure: { error in
                
            })
        }
    }
    
    
}

// MARK: UITableViewDelegate
extension SearchScreenView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as! SearchResultCell
        let result = results[indexPath.row]
        
        cell.set(result: result)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
