import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var titleView: UILabel!

    public static let identifier = "SearchResultCell"

    public func set(result: String) {
        titleView.text = result

    }

}
