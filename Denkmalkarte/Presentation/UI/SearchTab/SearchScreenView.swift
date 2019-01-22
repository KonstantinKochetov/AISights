import UIKit

public class SearchScreenView: UIViewController, UISearchBarDelegate, SearchScreenViewProtocol {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultsCountView: UILabel!

    var presenter: SearchScreenPresenterProtocol?

    private var results: [Denkmal] = []
    
    lazy var pickerManager: PickerManager = {
        let pickerManager = PickerManager(option: .title)
        dummyTextField.inputView = pickerManager.optionPicker
        dummyTextField.inputAccessoryView = pickerManager.toolbar
        return pickerManager
    }()
    
    let dummyTextField = UITextField()

    var option: PickerOption = .title {
        didSet {
            navigationItem.rightBarButtonItem?.title = itemTitle
        }
    }

    var itemTitle: String {
        return "by \(option.description)"
    }

    public override func viewDidLoad() {
        // init
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: DenkmalCell.identifier, bundle: Bundle(for: DenkmalCell.self)), forCellReuseIdentifier: DenkmalCell.identifier)
        view.addSubview(dummyTextField)
        pickerManager.delegate = self
        setupNavigationBar()
        // default query
        presenter?.search(query: "Wohnanlage",
                          option: option.description.lowercased(),
                          success: { result in
                            self.showSearchResult(result)
        }, failure: { _ in
        })
    }

    private func setupNavigationBar() {
        title = "Search"
        let filterBarButtonItem = UIBarButtonItem(title: itemTitle, style: .done, target: self, action: #selector(showOptions))
        navigationItem.rightBarButtonItem = filterBarButtonItem
    }
    
    @objc private func showOptions() {
        dummyTextField.becomeFirstResponder()
    }

    // MARK: UISearchBarDelegate
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let query = searchBar.text {
            presenter?.search(query: query,
                              option: option.description.lowercased(),
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
}

extension SearchScreenView: PickerManagerDelegate {

    func manager(_ manager: PickerManager, didPickOption option: PickerOption) {
        self.option = option
        dummyTextField.resignFirstResponder()
    }

}
