import UIKit

class DenkmalCell: UITableViewCell {

    @IBOutlet weak var denkmalImageView: UIImageView!

    @IBOutlet weak var denkmalNameLabel: UILabel!

    @IBOutlet weak var denkmalDescriptionLabel: UILabel!

    @IBOutlet weak var streetLabel: UILabel!

    public static let identifier = "DenkmalCell"

    public func set(denkmal: Denkmal) {
        denkmalImageView.image = UIImage(named: "testimage")
        
        streetLabel.text = denkmal.location + " " + denkmal.street
        denkmalDescriptionLabel.text = denkmal.text
        
    }

}
