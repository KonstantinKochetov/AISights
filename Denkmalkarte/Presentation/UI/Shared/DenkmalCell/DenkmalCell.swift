import UIKit
import AlamofireImage
import Alamofire

class DenkmalCell: UITableViewCell {
    @IBOutlet weak var denkmalImageView: UIImageView!
    @IBOutlet weak var denkmalNameLabel: UILabel!
    @IBOutlet weak var denkmalDescriptionLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    public static let identifier = "DenkmalCell"

    public func set(denkmal: Denkmal) {
        denkmalImageView.image = nil
        do {
            if !denkmal.image.isEmpty {
                debugPrint(denkmal.image)
                let imageUrl = URL(string: denkmal.image[0])!
                denkmalImageView.af_setImage(withURL: imageUrl, placeholderImage: UIImage(named: "sight"))
            }

            denkmalNameLabel.text = denkmal.title
            denkmalDescriptionLabel.text = denkmal.text
            streetLabel.text = denkmal.strasse[0]
        }
    }
}
