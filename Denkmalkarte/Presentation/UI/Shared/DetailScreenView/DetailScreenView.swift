import Foundation
import UIKit
import MapKit
import MobileCoreServices
import RealmSwift

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

    var presenter: DetailScreenPresenterProtocol?
    var monument: RealmDenkmal = RealmDenkmal(id: "1", markiert: false, title: "Brandenburger Tor", ort: "Berlin", latitude: "11", longitude: "22", entwurfUndAusfuehrung: List<String>(), ausfuehrung: List<String>(), baubeginn: "1900", fertigstellung: "1950", ausfuehrungUndBauherrUndEntwurf: "", entwurfUndFertigstellung: "1971", literatur: "", ausfuehrungUndBauherr: "", planungsbeginn: "1911", entwurfUndDatierung: "1944", planungUndAusfuehrung: "1955", entwurfUndBaubeginnUndFertigstellung: "1922", entwurf: List<String>(), bauherr: List<String>(), text: "In Zehlendorf hatte man 1887 durch eine Unterführung die Verbindung zwischen nördlichen und südlichen Ortsabschnitten hergestellt, die durch den Bahnverlauf voneinander getrennt waren; eine zweite Unterführung auf der Höhe von Ahorn- und Karlstrasse, die von einem Bürgerkomitee gefordert wurde, kam nicht zustande. (199) Das neu errichtete Stationsgebäude des S-Bahnhofs Zehlendorf trug den veränderten Bedingungen Rechnung, die der starke Anstieg des Personenverkehrs mit sich gebracht hatte: Im Stationsgebäude wurden die Fahrkarten verkauft, am Eingang zum Bahnsteig fand die Kontrolle statt, und für die Wartezeit hielten sich die Reisenden auf den Bahnsteigen mit Wartebuden und Kiosken auf. Wartesäle im Gebäude waren entsprechend überflüssig geworden, die Zehlendorfer Station umschloss nur noch eine grosse Halle mit Verkaufsschaltern und Räume für die Gepäckaufbewahrung. Der Aussenbau wurde im zeitgemässen Mittelalterstil ziegelsichtig mit Blendgiebeln und glasierten Klinkern aufgeführt. (200)199) Trumpa 1983, S. 73.200) Jaeggi o. J., S. 45.", wiederaufbau: "1911", umbau: "1932", entwurfUndBaubeginn: "1834", image: List<String>(), strasse: List<String>(), planung: "1933", entwurfUndBauherr: "", eigentuemer: "", datierung: List<String>())

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
        addressLabel.text = monument.strasse.first
        descriptionLabel.text = monument.text
        yearLabel.text = monument.fertigstellung
        architectLabel.text = monument.entwurfUndBauherr
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

// MARK: - Image Picker Manager

protocol ImagePickerManagerDelegate: class {
    func manager(_ manager: ImagePickerManager, didPickImage image: UIImage)
}

class ImagePickerManager: NSObject {

    private var imagePickerController: UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        return imagePickerController
    }

    weak var delegate: ImagePickerManagerDelegate?

    func showOptionsAlertController(inViewController viewController: UIViewController) {
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { _ in
            self.imagePickerController.sourceType = .camera
            viewController.present(self.imagePickerController, animated: true, completion: nil)
        }

        let choosePhotoAction = UIAlertAction(title: "Choose from Library", style: .default) { _ in
            self.imagePickerController.sourceType = .photoLibrary
            viewController.present(self.imagePickerController, animated: true, completion: nil)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let choosePhotoAlterController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        choosePhotoAlterController.addAction(takePhotoAction)
        choosePhotoAlterController.addAction(choosePhotoAction)
        choosePhotoAlterController.addAction(cancelAction)

        viewController.present(choosePhotoAlterController, animated: true, completion: nil)
    }
}

extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            delegate?.manager(self, didPickImage: image)
        }
    }
}

// MARK: Image Compression

fileprivate let maxImageSize: CGFloat = 1024
fileprivate let minImageSize: CGFloat = 512
fileprivate let compressionAmount: CGFloat = 0.7

enum ImageCompressionError: Error {
    case imageTooSmall
    case badImageRatio
}

extension UIImage {

    public func compress(completion: @escaping (Data?, CGFloat?, CGFloat?, Error?) -> Void) {
        let width = self.size.width
        let height = self.size.height

        if width < 512 || height < 512 {
            completion(nil, nil, nil, ImageCompressionError.imageTooSmall)
            return
        }

        if width < height / 2 || height < width / 2 {
            completion(nil, nil, nil, ImageCompressionError.badImageRatio)
            return
        }

        let newWidth: CGFloat
        let newHeight: CGFloat

        if width <= maxImageSize && height <= maxImageSize {
            newWidth = width
            newHeight = height
        } else if width > height {
            let factor = maxImageSize / width

            newWidth = maxImageSize
            newHeight = height * factor
        } else if width < height {
            let factor = maxImageSize / height

            newWidth = width * factor
            newHeight = maxImageSize
        } else {
            newWidth = maxImageSize
            newHeight = maxImageSize
        }

        let rect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)

        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let jpegImage = (scaledImage ?? UIImage()).jpegData(compressionQuality: compressionAmount)

        completion(jpegImage, newWidth, newHeight, nil)
    }

}
