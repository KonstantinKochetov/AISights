import UIKit
import MapKit

public class DetailScreenView: UIViewController, DetailScreenViewProtocol {
    
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var distanceLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var streetLabel: UILabel!
    @IBOutlet private var textLabel: UILabel!
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var presenter: DetailScreenPresenterProtocol?
    var monument: RealmDenkmal?
    
    public override func viewDidLoad() {
        setup()
    }
    
    // MARK: Actions
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func directionsButtonTapped(_ sender: Any) {
        openMonumentInMaps()
    }
    
    // MARK: - Helpers
    
    private func setup() {
        // TODO: Set Image
        titleLabel.text = monument.title
        streetLabel.text = monument.street
        textLabel.text = monument.text
    }
    
    private func openMonumentInMaps() {
        let coordinate = monument.toDenkmal().coordinate
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = monument.title
        mapItem.openInMaps(launchOptions: nil)
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
