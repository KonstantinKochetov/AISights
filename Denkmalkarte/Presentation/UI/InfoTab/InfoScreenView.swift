import Foundation

import UIKit

enum CellType {
    case standardCell
    case imageCell
}

class InfoScreenView: UIViewController, InfoScreenViewProtocol {

    var presenter: InfoScreenPresenterProtocol?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoScreenLabel: UILabel!
    private var results: [String] = ["1", "2", "3"]
    private var pinImages: [UIImage] = [UIImage(named: "blue-pin")!, UIImage(named: "red-pin")!, UIImage(named: "shovel")!]
    public var shovelImages: [UIImage] = [UIImage(named: "shovel")!, UIImage(named: "shovel")!, UIImage(named: "shovel")!]

    private var textForPins: [String] = ["Mehrere Denkmäler in einer Straße", "", "Bewerten sie Denkmäler"]
    private var textForShovels: [String] = ["x1 Unzufrieden", "x3 Befriedigend", "x5 Gefällt mir"]
    private var headerForPins: [String] = ["Ensemble", "Einzelnes Denkmal", "Bewertung"]
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
        //let result = results[indexPath.row]
        //if indexPath.row == 2 {
        //   cell?.cellType = .imageCell
        // }
        let textForPin = textForPins[indexPath.row]
        let textForPinHeader = headerForPins[indexPath.row]
        let pinImage = pinImages[indexPath.row]
        let shovelImage = shovelImages[indexPath.row]
        cell?.set(pinImages: pinImage, textForPin: textForPin, textForPinHeader: textForPinHeader, shovelImages: shovelImage, textForShovels: textForShovels, indexRow: indexPath.row )
        return cell!
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
