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
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()

        }
        /*let initCenterMap = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        centerMapOnLocation(location: initCenterMap)*/

        showLocalDenkmal()

         mapView.showsUserLocation = true

        presenter?.getDenkmale(success: { result in
            self.mapView.addAnnotations(result)
        }, failure: {error in
            print(error.localizedDescription)
        })

        super.viewDidLoad()
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Logo"))
        imageView.contentMode = .scaleAspectFit
        let contentView = UIView()
        contentView.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false

        let layoutConstraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]

        NSLayoutConstraint.activate(layoutConstraints)

        navigationItem.titleView = contentView
    }

    func showLocalDenkmal() {
        print("in showLocationDenkmal")
        let testLocatin = locationManager.location
        print("TestLocation \(String(describing: testLocatin))")
        if let tst = testLocatin {
            centerMapOnLocation(location: tst)
            print("get userLocation: ")
        }
        creatUserActivity()
    }
    func creatUserActivity() {
        print("crateUserActivity")
        let activity = NSUserActivity(activityType: UserActivityType.ShowLocalDenkmal)
        activity.title = "Zeige Denkmäler"
        activity.isEligibleForPrediction = true
        activity.isEligibleForSearch = true
        self.userActivity = activity
        self.userActivity?.becomeCurrent()
    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
extension MapScreenView: MKMapViewDelegate {
    public func  mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? Denkmal else {
            return nil
        }

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
            /*let btnNavi = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            btnNavi.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControl.State())*/
            view.leftCalloutAccessoryView = UIButton(type: .infoDark)
            view.clusteringIdentifier = "denkmal"

        }
        return view
    }

    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        if view.rightCalloutAccessoryView == control {
            if let tempDenkmal: Denkmal = view.annotation as? Denkmal {
                let denkmal = tempDenkmal
                presenter?.showDetailView(denkmal)
            }
        }
        if view.leftCalloutAccessoryView == control {
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            if let tempDenkmal: Denkmal = view.annotation as? Denkmal {
                tempDenkmal.mapItem().openInMaps(launchOptions: launchOptions)
            }

        }

    }
}
