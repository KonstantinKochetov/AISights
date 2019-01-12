import Foundation
import UIKit
import MapKit
import MobileCoreServices
import RealmSwift
import FirebaseDatabase

public class DetailScreenView: UIViewController, DetailScreenViewProtocol {

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var distanceLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var yearLabel: UILabel!
    @IBOutlet private var architectLabel: UILabel!
    @IBOutlet private var userPhotosCollectionView: UICollectionView!

    var presenter: DetailScreenPresenterProtocol?
    var monument: Denkmal?
    var userId: String?

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
            presenter?.bookmark(id: monument.id, success: {
    
            }, failure: { _ in
            })
        }
    }

    @IBAction func like(_ sender: Any) {
        if let monument = monument, let userId = userId {
            presenter?.like(id: monument.id,
                            userId: userId,
                            success: {
                                //                          // do nothing
            }, failure: { _ in
            })
        }
    }
    
    // MARK: - Helpers
    
    private func setup() {
        userId = presenter?.getUserId()
        if let monument = monument {
            // set listener to likes
            let ref: DatabaseReference = assembler.resolve().child("denkmale").child(monument.id).child("likes")
            ref.observe(DataEventType.value, with: { snapshot in
                let value2 = snapshot.value ?? -9
                let value = value2 as? NSNumber
                if let value = value {
                    self.distanceLabel.text = value.stringValue
                }
            })
            
            titleLabel.text = monument.title
            addressLabel.text = monument.strasse[0]
            //textLabel.text = monument.text
            
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
    
    private func setupCollectionView() {
        userPhotosCollectionView.dataSource = self
        userPhotosCollectionView.delegate = self
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

// MARK: - UICollectionViewDataSource

extension DetailScreenView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegate

extension DetailScreenView: UICollectionViewDelegate {
    
}
