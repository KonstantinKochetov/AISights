import UIKit
import MapKit

public class MapScreenView: UIViewController, MapScreenViewProtocol {
    @IBOutlet weak var dataLabel: UILabel!

    @IBOutlet weak var mapView: MKMapView!

    var presenter: MapScreenPresenterProtocol?

    @IBAction func mapTestButton(_ sender: Any) {
        presenter?.showDetailView()
    }
    @IBAction func dataTestButton(_ sender: Any) {
        presenter?.getMapData(success: { result in
            self.dataLabel.text = result
        }, failure: { error in
            self.dataLabel.text = error.localizedDescription

        }
        )
        presenter?.getPointAnnotation(success: { result in
            self.mapView.addAnnotation(result)
            }, failure: {_ in

        })

    }
}
