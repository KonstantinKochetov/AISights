import UIKit
import MapKit

public class MapScreenView: UIViewController, MapScreenViewProtocol {
    @IBOutlet weak var dataLabel: UILabel!

    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 10000

    var presenter: MapScreenPresenterProtocol?
    
    override public func viewDidLoad() {
        mapView.delegate = self
        
        let initCenterMap = CLLocation(latitude: 52.520008, longitude: 13.404954)
        centerMapOnLocation(location: initCenterMap)
        presenter?.getPointAnnotation(success: { result in
            self.mapView.addAnnotation(result)
        }, failure: {_ in
            
        })
      
        super.viewDidLoad()
        
    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

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
    }
}
extension MapScreenView: MKMapViewDelegate{
    private func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      
        guard let annotation = annotation as? Denkmal else { return nil }
       
        let identifier = "marker"
        var view: MKMarkerAnnotationView
       
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
           
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
}
