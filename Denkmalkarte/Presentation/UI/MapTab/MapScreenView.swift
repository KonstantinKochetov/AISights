import UIKit
import MapKit

public class MapScreenView: UIViewController, MapScreenViewProtocol, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 10000
    let locationManager = CLLocationManager()

    var presenter: MapScreenPresenterProtocol?

    override public func viewDidLoad() {
        mapView.delegate = self
        locationManager.delegate = self

        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestWhenInUseAuthorization()
        }
        let initCenterMap = CLLocation(latitude: 52.520008, longitude: 13.404954)
        mapView.showsUserLocation = true
        centerMapOnLocation(location: initCenterMap)
        presenter?.getDenkmale(success: { result in
            self.mapView.addAnnotations(result)
        }, failure: {error in
            print(error.localizedDescription)
        })

        super.viewDidLoad()

    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
extension MapScreenView: MKMapViewDelegate {
    public func  mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

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
            view.clusteringIdentifier = "denkmal"

        }
        return view
    }

    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Denkmal
        print(location.title!)
        presenter?.showDetailView([1])
    }
}
