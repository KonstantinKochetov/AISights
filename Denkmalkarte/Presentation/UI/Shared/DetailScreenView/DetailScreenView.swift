import Foundation
import UIKit
import MapKit
import MobileCoreServices
import RealmSwift
import FirebaseDatabase
import Firebase

public class DetailScreenView: UIViewController, DetailScreenViewProtocol {

    public override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var gradientView: GradientView!
    @IBOutlet private var likesVisualEffectView: UIVisualEffectView!
    @IBOutlet private var likesLabel: UILabel!
    @IBOutlet private var distanceLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var addressStackView: UIStackView!
    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var descriptionStackView: UIStackView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var yearStackView: UIStackView!
    @IBOutlet private var yearLabel: UILabel!
    @IBOutlet private var builderStackView: UIStackView!
    @IBOutlet private var builderLabel: UILabel!
    @IBOutlet private var literatureStackView: UIStackView!
    @IBOutlet private var literatureLabel: UILabel!
    @IBOutlet private var userPhotosCollectionView: UICollectionView!

    lazy var imagePickerManager: ImagePickerManager = {
        let imagePickerManager = ImagePickerManager()
        imagePickerManager.delegate = self
        return imagePickerManager
    }()

    var presenter: DetailScreenPresenterProtocol?
    var monument: Denkmal?
    var userId: String?
    var userImageNames = [String]() {
        didSet {
            userPhotosCollectionView.reloadData()
            updateCollectionViewHeightConstraint()
        }
    }

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
        guard let monument = monument, let userId = userId else {
            return
        }

        presenter?.like(id: monument.id, userId: userId, success: {

        }, failure: { _ in
        })

        self.likesVisualEffectView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
    }

    // MARK: - Helpers

    private func setup() {
        userId = presenter?.getUserId()
        setupCollectionView()
        setupImage()
        setupInfo()
        setupLikes()
        setupUserImages()
    }

    private func setupCollectionView() {
        userPhotosCollectionView.dataSource = self
        userPhotosCollectionView.delegate = self
        let nib = UINib(nibName: PhotoCell.identifier, bundle: Bundle.main)
        userPhotosCollectionView.register(nib, forCellWithReuseIdentifier: PhotoCell.identifier)
    }

    private func setupInfo() {
        guard let monument = monument else {
            return
        }

        titleLabel.text = monument.title

        if !monument.strasse.isEmpty {
            let addresses = createMultilineString(monument.strasse)
            addressLabel.text = addresses
            addressStackView.isHidden = false
        }

        if !monument.text.isEmpty {
            let description = monument.text
            descriptionLabel.text = description
            descriptionStackView.isHidden = false
        }

        if !monument.bauherr.isEmpty {
            let builder = createMultilineString(monument.bauherr)
            builderLabel.text = builder
            builderStackView.isHidden = false
        }

        if let years = createYears() {
            yearLabel.text = years
            yearStackView.isHidden = false
        }

        if !monument.literatur.isEmpty {
            literatureLabel.text = monument.literatur
            literatureStackView.isHidden = false
        }
    }

    private func createYears() -> String? {
        guard let monument = monument else {
            return nil
        }

        var years: [String] = []

        if !monument.planung.isEmpty {
            years.append("Planung: \(monument.planung)")
        }

        if !monument.baubeginn.isEmpty {
            years.append("Baubeginn: \(monument.baubeginn)")
        }

        if !monument.baubeginn.isEmpty {
            years.append("Baubeginn: \(monument.baubeginn)")
        }

        if !monument.fertigstellung.isEmpty {
            years.append("Fertigstellung: \(monument.fertigstellung)")
        }

        if !monument.datierung.isEmpty {
            years.append("Datierung: \(monument.datierung.first!)")
        }

        if !monument.umbau.isEmpty {
            years.append("Umbau: \(monument.umbau)")
        }

        if !monument.wiederaufbau.isEmpty {
            years.append("Datierung: \(monument.wiederaufbau.first!)")
        }

        let multilineString = createMultilineString(years)
        return !multilineString.isEmpty ? multilineString : nil
    }

    private func createMultilineString(_ stringArray: [String]) -> String {
        var multilineString = String()

        for (index, string) in stringArray.enumerated() {
            multilineString.append(string)
            
            if index < stringArray.count - 1 {
                multilineString.append("\n")
            }
        }

        return multilineString
    }

    private func setupImage() {
        guard let monument = monument else {
            return
        }

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

    private func setupLikes() {
        guard let monument = monument else {
            return
        }

        let ref: DatabaseReference = assembler
            .resolve()
            .child("denkmale")
            .child(monument.id)
            .child("likes")

        ref.observe(DataEventType.value) { snapshot in
            guard let value = (snapshot.value ?? -9) as? NSNumber else {
                return
            }

            self.likesLabel.text = value.stringValue
        }
    }

    private func setupUserImages() {
        guard let monument = monument else {
            return
        }

        let ref: DatabaseReference = assembler
            .resolve()
            .child("denkmale")
            .child(monument.id)
            .child("images")

        ref.observeSingleEvent(of: .value) { snapshot in
            let names = snapshot.children.compactMap(self.mapChildToValue)
            self.userImageNames = names
        }

        ref.observe(.childAdded) { snapshot in
            let names = snapshot.children.compactMap(self.mapChildToValue)
            self.userImageNames.append(contentsOf: names)
        }
    }

    private func mapChildToValue(_ child: Any) -> String? {
        guard let child = child as? DataSnapshot,
            let value = child.value as? String else {
                return nil
        }

        return value
    }

    private func updateCollectionViewHeightConstraint() {
        let heightConstraint = userPhotosCollectionView.constraints.first {
            $0.firstAttribute == .height
        }

        heightConstraint?.constant = 100
        userPhotosCollectionView.setNeedsUpdateConstraints()
        userPhotosCollectionView.layoutIfNeeded()
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
            let imageViewScale = 1 - yOffset / imageView.bounds.height
            let gradientViewScale = 1 - yOffset / gradientView.bounds.height
            let imageViewTransform = CGAffineTransform(translationX: 0, y: yOffset / 2).scaledBy(x: imageViewScale, y: imageViewScale)
            let gradientViewTransform = CGAffineTransform(translationX: 0, y: yOffset / 2).scaledBy(x: gradientViewScale, y: gradientViewScale)
            if yOffset <= 0 {
                imageView.transform = imageViewTransform
                gradientView.transform = gradientViewTransform
            }
        }
    }

}

// MARK: - UICollectionViewDataSource

extension DetailScreenView: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userImageNames.count + 1
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell

        if indexPath.row < userImageNames.count {
            let name = userImageNames[indexPath.row]
            cell?.setup(withImageId: name)
        } else {
            cell?.setupWithCameraIcon()
        }

        return cell!
    }

}

// MARK: - UICollectionViewDelegate

extension DetailScreenView: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let withWithoutSpacing = width - 2 * 8
        let itemWidth = withWithoutSpacing / 3
        return CGSize(width: itemWidth, height: itemWidth)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == userImageNames.count {
            imagePickerManager.showCamera(in: self)
        }
    }

}

// MARK: - ImagePickerManagerDelegate

extension DetailScreenView: ImagePickerManagerDelegate {

    func manager(_ manager: ImagePickerManager, didPickImage image: UIImage) {
        presenter?.upload(image, withMonumentId: monument!.id, success: {
            
        }, failure: { error in

        })
    }

}
