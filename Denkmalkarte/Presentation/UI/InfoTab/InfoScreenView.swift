import Foundation

import UIKit

public class InfoScreenView: UIViewController, InfoScreenViewProtocol {

    var presenter: InfoScreenPresenterProtocol?

    @IBOutlet weak var tableView: UITableView!
    
    private var results: [String] = ["1", "2", "3"]
    
    public override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: InfoPinCell.identifier, bundle: Bundle(for: InfoPinCell.self)), forCellReuseIdentifier: InfoPinCell.identifier)
        
    }
    
}


// MARK: UITableViewDelegate
extension InfoScreenView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoPinCell.identifier, for: indexPath) as? InfoPinCell
        let result = results[indexPath.row]
        
        cell?.set(result: result)
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
