import UIKit

public class DetailScreenView: UIViewController, DetailScreenViewProtocol {
    
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var distanceLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    
    var presenter: DetailScreenPresenterProtocol?
    
    // MARK: Actions
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - UIScrollViewDelegate

extension DetailScreenView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let yOffset = scrollView.contentOffset.y
            let scale = 1 - yOffset / imageView.bounds.height
            let transform = CGAffineTransform(translationX: 0, y: yOffset / 2).scaledBy(x: scale, y: scale)
            if yOffset <= 0 { imageView.transform = transform }
        }
    }
    
}
