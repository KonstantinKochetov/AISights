import UIKit
import AlamofireImage

class DenkmalCell: UITableViewCell {
    
    @IBOutlet weak var denkmalImageView: UIImageView!
    
    @IBOutlet weak var denkmalNameLabel: UILabel!
    
    @IBOutlet weak var denkmalDescriptionLabel: UILabel!
    
    @IBOutlet weak var streetLabel: UILabel!
    
    public static let identifier = "DenkmalCell"
    
    public func set(denkmal: Denkmal) {
        //denkmalImageView.image = UIImage(named: "testimage")
        // TODO  this is testing. It will be changed after parsing fix
        let filter = AspectScaledToFillSizeFilter(size: denkmalImageView.frame.size)
        do {
            if (!denkmal.image.isEmpty) {
                let image = UIImage()
                let imageUrl = try URL(string: denkmal.image)!
                denkmalImageView.af_setImage(withURL: imageUrl, filter: filter)
            }
        } catch {
            denkmalImageView.image = UIImage(named: "testimage")
        }
        streetLabel.text = denkmal.location + " " + denkmal.street
        denkmalDescriptionLabel.text = denkmal.literature
        denkmalNameLabel.text = denkmal.builderOwner
        
    }
    
}
