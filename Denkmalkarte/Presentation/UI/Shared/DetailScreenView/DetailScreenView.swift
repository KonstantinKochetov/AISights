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
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var bookmarkButton: UIButton!
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
    @IBOutlet private var userPhotosCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var uploadView: UIView!
    @IBOutlet private var uploadViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var uploadProgressLabel: UILabel!

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
    var photoCellFrame: CGRect? = nil

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

    @IBAction func shareButtonTapped(_ sender: Any) {
        openShare()
    }

    @IBAction func bookmark(_ sender: Any) {
        if let monument = monument {
            presenter?.bookmark(id: monument.id, success: {

            }, failure: { _ in
            })
        }

        let isPressed = bookmarkButton.backgroundColor == UIColor.black

        bookmarkButton.backgroundColor = isPressed ? UIColor.white : UIColor.black
        bookmarkButton.tintColor = isPressed ? UIColor.black : UIColor.white
    }

    @IBAction func like(_ sender: Any) {
        guard let monument = monument, let userId = userId else {
            return
        }

        presenter?.like(id: monument.id, userId: userId, success: {

        }, failure: { _ in
        })

        let isPressed = likeButton.backgroundColor == UIColor.black

        likeButton.backgroundColor = isPressed ? UIColor.white : UIColor.black
        likeButton.tintColor = isPressed ? UIColor.black : UIColor.white
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
        let height = userPhotosCollectionView.contentSize.height + 32
        userPhotosCollectionViewHeightConstraint.constant = height
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

    private func openShare() {
        guard let monument = monument,
            let title = monument.title ,
            let street = monument.strasse.first else {
            return
        }

        let text = "Check out \(title) at \(street)."
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        present(activityViewController, animated: true, completion: nil)
    }

    private func upload(image: UIImage) {
        toggleUploadView()

        presenter?.upload(image, withMonumentId: monument!.id, progressHandler: { progress in
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.percent
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.multiplier = 100

            let formattedNumber = numberFormatter.string(from: NSNumber(value: progress))
            self.uploadProgressLabel.text = formattedNumber
        }, success: {
            self.toggleUploadView()
        }, failure: { _ in
            self.toggleUploadView()
        })
    }

    private func toggleUploadView() {
        let isVisible = uploadViewBottomConstraint.constant > (0 as CGFloat)

        uploadViewBottomConstraint.constant = isVisible ? -150 : 32

        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.uploadView.layoutIfNeeded()
        }, completion: nil)
    }

    private func expandUserPhoto(of cell: PhotoCell) {
        let desiredWidthAndHeight = view.bounds.width - 32
        let scale = desiredWidthAndHeight / cell.bounds.width

        let offsetX = (view.bounds.width - cell.bounds.width) / 2
        let translationX = (offsetX - (cell.frame.origin.x + 32)) / scale

        let offsetY = (view.bounds.height - cell.bounds.height) / 2
        let relativeFrame = userPhotosCollectionView.convert(cell.frame, to: view)
        let translationY = (offsetY - relativeFrame.origin.y) / scale

        let translationTransform = CGAffineTransform(translationX: translationX, y: translationY)
        let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
        let transform = translationTransform.concatenating(scaleTransform)

        userPhotosCollectionView.bringSubviewToFront(cell)

        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            cell.transform = transform
        }, completion: nil)
    }

    private func collapseUserPhoto(of cell: PhotoCell) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            cell.transform = CGAffineTransform.identity
        }, completion: nil)
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
            cell?.delegate = self
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

// MARK: - PhotoCellDelegate

extension DetailScreenView: PhotoCellDelegate {

    func cellDidStartLongPress(_ cell: PhotoCell) {
        expandUserPhoto(of: cell)
    }

    func cellDidEndLongPress(_ cell: PhotoCell) {
        collapseUserPhoto(of: cell)
    }

}

// MARK: - ImagePickerManagerDelegate

extension DetailScreenView: ImagePickerManagerDelegate {

    func manager(_ manager: ImagePickerManager, didPickImage image: UIImage) {
        upload(image: image)
    }

}
