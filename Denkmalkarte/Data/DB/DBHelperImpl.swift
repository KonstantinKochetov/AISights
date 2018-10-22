import Foundation
import MapKit
class DbHelperImpl: DbHelper {
    func getPointAnnotation() -> MKPointAnnotation? {

        //
        let geocoder = CLGeocoder()
        let mokAnnotation = MKPointAnnotation()

        let address = "- Lichtenberg,Josef-Orlopp-Straße: 44, 46, 48, 50, 52"
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil) {
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates: CLLocationCoordinate2D = placemark.location!.coordinate
                mokAnnotation.coordinate = coordinates
                mokAnnotation.title = "TestAnnotaion"
            }
        })

        return mokAnnotation
    }

    func getMapData() -> String? {
        return "map data from db"
    }

}
