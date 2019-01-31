import Foundation
import UIKit
import MapKit
import MobileCoreServices
import RealmSwift
import FirebaseDatabase
import Firebase
import CoreML
import Vision
import ImageIO


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
    @IBOutlet private var userPhotosStackView: UIStackView!
    @IBOutlet private var userPhotosCollectionView: UICollectionView!
    @IBOutlet private var userPhotosCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var uploadView: UIView!
    @IBOutlet private var uploadViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var uploadProgressLabel: UILabel!

    var currentImage: UIImage = UIImage()

    lazy var imagePickerManager: ImagePickerManager = {
        let imagePickerManager = ImagePickerManager()
        imagePickerManager.delegate = self
        return imagePickerManager
    }()

    /// - Tag: MLModelSetup
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            /*
             Use the Swift class `MobileNet` Core ML generates from the model.
             To use a different Core ML classifier model, add it to the project
             and replace `MobileNet` with that model's generated Swift class.
             */
            let model = try VNCoreMLModel(for: ImageClassifier().model)

            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()

    var presenter: DetailScreenPresenterProtocol?
    var monument: Denkmal?
    var currentLocation = LocationManager.shared.location
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

    /// - Tag: PerformRequests
    func updateClassifications(for image: UIImage) {
        print("Classifying...")

        currentImage = image

        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }

        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                /*
                 This handler catches general image processing errors. The `classificationRequest`'s
                 completion handler `processClassifications(_:error:)` catches errors specific
                 to processing that request.
                 */
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }

    /// Updates the UI with the results of the classification.
    /// - Tag: ProcessClassifications
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                print("Unable to classify image.\n\(error!.localizedDescription)")
                return
            }
            // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
            let classifications = results as? [VNClassificationObservation]

            if let classifications = classifications {
                if classifications.isEmpty {
                    print("Nothing recognized.")
                } else {
                    // Display top classifications ranked by confidence in the UI.
                    let topClassifications = classifications.prefix(2)
                    let descriptions = topClassifications.map { classification in
                        // Formats the classification for display; e.g. "(0.37) cliff, drop, drop-off".
                        return String(format: "  (%.2f) %@", classification.confidence, classification.identifier)
                    }
                    print("Classification:\n" + descriptions.joined(separator: "\n"))

                    let classification = descriptions.filter({$0.contains("notbuilding")})
                    let value = Double(classification[0].substring(3, end: 6))
                    if let value = value {
                        if value > 0.40 {
                            let alert = UIAlertController(title: "Oops!", message: "It seems like this photo is not really a building! Please try again", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        } else {
                            self.upload(image: self.currentImage)
                        }

                    }
                }
            }
        }
    }

    private func setup() {
        userId = presenter?.getUserId()
        setupCollectionView()
        setupImage()
        setupInfo()
        setupLikes()
        setupDistance()
        setupUserImages()
    }

    private func setupCollectionView() {
        userPhotosCollectionView.dataSource = self
        userPhotosCollectionView.delegate = self
        let nib = UINib(nibName: PhotoCell.identifier, bundle: Bundle.main)
        userPhotosCollectionView.register(nib, forCellWithReuseIdentifier: PhotoCell.identifier)
        userPhotosStackView.bringSubviewToFront(userPhotosCollectionView)
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
                var http = monument.image[0]
                if http.contains("http://") {
                    http = monument.image[0].replacingOccurrences(of: "http://", with: "https://")
                }
                let imageUrl = URL(string: http)!
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

    private func setupDistance() {
        guard let monument = monument, let currentLocation = currentLocation else {
            distanceLabel.text = NSLocalizedString("∞ away", comment: "")
            return
        }

        let monumentLocation = CLLocation(latitude: monument.coordinate.latitude, longitude: monument.coordinate.longitude)
        let distance = monumentLocation.distance(from: currentLocation)

        let distanceFormatter = MKDistanceFormatter()
        let formattedDistance = distanceFormatter.string(fromDistance: distance)

        distanceLabel.text = formattedDistance + NSLocalizedString(" away", comment: "")
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
        var height = userPhotosCollectionView.contentSize.height
        if height == 0 {
            height = 100
        }
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

    private func checkImageAndUpload(image: UIImage) {
        updateClassifications(for: image)
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
            self.setup()
        }, failure: { _ in
            self.toggleUploadView()
        })
    }

    private func toggleUploadView() {
        let isVisible = uploadViewBottomConstraint.constant > (0 as CGFloat)

        uploadViewBottomConstraint.constant = isVisible ? -150 : 32

        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.uploadView.layoutSubviews()
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
        checkImageAndUpload(image: image)
    }

}

extension String {
    func substring(_ start: Int, end: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        return String(self[startIndex...endIndex])
    }
}
