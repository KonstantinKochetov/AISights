import UIKit

class DenkmalCell: UITableViewCell {

    @IBOutlet weak var denkmalImageView: UIImageView!

    @IBOutlet weak var denkmalNameLabel: UILabel!

    @IBOutlet weak var denkmalDescriptionLabel: UILabel!

    @IBOutlet weak var denkmalDistanceLabel: UILabel!

    public static let identifier = "DenkmalCell"

    public func set(result: String) {
        denkmalImageView.image = UIImage(named: "testimage")
    }

}
