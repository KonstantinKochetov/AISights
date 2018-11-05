import UIKit

class SearchResultCell: UITableViewCell {

    
    @IBOutlet weak var denkmalImageView: UIImageView!
    
    @IBOutlet weak var denkmalNameLabel: UILabel!
    
    @IBOutlet weak var denkmalDescriptionLabel: UILabel!
    
    @IBOutlet weak var denkmalDistanceLabel: UILabel!
    public static let identifier = "SearchResultCell"

    public func set(result: String) {

    }

}
