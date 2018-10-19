import UIKit

public class SearchScreenView: UIViewController, SearchScreenViewProtocol {

    var presenter: SearchScreenPresenterProtocol?

    @IBAction func goToDetailButton(_ sender: Any) {
        presenter?.showDetailView()
    }

}
