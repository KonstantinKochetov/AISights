import UIKit
import MapKit
import FirebaseDatabase

public class DetailScreenView: UIViewController, DetailScreenViewProtocol {
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var distanceLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var streetLabel: UILabel!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet weak var bookmark: UIButton!

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    var presenter: DetailScreenPresenterProtocol?
    var monument: Denkmal?

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
    @IBAction func bookmark(_ sender: Any) {
        if let monument = monument {
            presenter?.bookmark(id: monument.id,
                                success: {
                                    // TODO alert/UI

            }, failure: { _ in
                // TODO alert/UI
            })
        }
    }
    @IBAction func like(_ sender: Any) {
        if let monument = monument {
            presenter?.like(id: monument.id,
                            userId: "8972",
                            success: {
//                          // do nothing
            }, failure: { _ in
                // TODO alert/UI
            })
        }
    }

    // MARK: - Helpers
    private func setup() {
        if let monument = monument {

            // set listener
            let ref : DatabaseReference = assembler.resolve().child("denkmale").child(monument.id).child("likes")
            ref.observe(DataEventType.value, with: { snapshot in
                let value2 = snapshot.value ?? -9
                let value = value2 as? NSNumber
                if let value = value {
                    self.distanceLabel.text = value.stringValue
                }
            })

            titleLabel.text = monument.title
            streetLabel.text = monument.strasse[0]
            textLabel.text = monument.text

            imageView.image = nil
            do {
                if !monument.image.isEmpty {
                    let imageUrl = URL(string: monument.image[0])!
                    imageView.af_setImage(withURL: imageUrl)
                } else {
                    imageView.image = UIImage(named: "sight")
                }
            }
        }
    }

        private func openMonumentInMaps() {
            if let monument = monument {
                let coordinate = monument.coordinate
                let placemark = MKPlacemark(coordinate: coordinate)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = monument.title
                mapItem.openInMaps(launchOptions: nil)
            }
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

