import UIKit

public class DetailScreenView: UIViewController, DetailScreenViewProtocol {

    var presenter: DetailScreenPresenterProtocol?
    var id: [Int]?

    public override func viewDidLoad() {
        if let test = id {
            print(test[0])
        }
    }

}
