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
                var http = denkmal.image[0]
                if http.contains("http://") {
                    http = denkmal.image[0].replacingOccurrences(of: "http://", with: "https://")
                }
                let imageUrl = URL(string: http)!
                denkmalImageView.af_setImage(withURL: imageUrl)
            } else {
                denkmalImageView.image = UIImage(named: "sight")
            }

            denkmalNameLabel.text = denkmal.title
            if !denkmal.strasse.isEmpty {
                streetLabel.text = denkmal.strasse[0]
            }
        }
    }
}
