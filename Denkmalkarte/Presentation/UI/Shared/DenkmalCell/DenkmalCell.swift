import UIKit
import AlamofireImage

class DenkmalCell: UITableViewCell {
    @IBOutlet weak var denkmalImageView: UIImageView!
    @IBOutlet weak var denkmalNameLabel: UILabel!
    @IBOutlet weak var denkmalDescriptionLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    public static let identifier = "DenkmalCell"

    public func set(denkmal: Denkmal) {
        let filter = AspectScaledToFillSizeFilter(size: denkmalImageView.frame.size)
        do {
            if !denkmal.image.isEmpty {
                debugPrint(denkmal.image)
                let imageUrl = URL(string: denkmal.image[0])!
                denkmalImageView.af_setImage(withURL: imageUrl, filter: filter)
            }
        }

    }
}
