import UIKit

public class SearchScreenView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UISearchBarDelegate, SearchScreenViewProtocol {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var resultsCountView: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!

    var presenter: SearchScreenPresenterProtocol?

    private var results: [Denkmal] = []
    let options = ["Title", "Text", "Bauherr", "Strasse", "Datierung", "Ort"]
    var option: String = "title"

    public override func viewDidLoad() {
        // init
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: DenkmalCell.identifier, bundle: Bundle(for: DenkmalCell.self)), forCellReuseIdentifier: DenkmalCell.identifier)

        // default query
        presenter?.search(query: "Wohnanlage",
                          option: "title",
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
        self.resultsCountView.text = "\(result.count) results"
        self.tableView.reloadData()
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        option = options[row].lowercased()
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
