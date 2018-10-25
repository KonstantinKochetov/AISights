import Foundation
import MapKit
class DbHelperImpl: DbHelper {
    func getPointAnnotation() -> MKAnnotation? {

        //
        //let geocoder = CLGeocoder()
        let mokAnnotation = Denkmal(title: "Test1", locationName: "NameTest1", descriptions: "BeschreibngTest1", coordinate: CLLocationCoordinate2D(latitude: 52.520008, longitude: 13.404954))
      
     
        
        
        

        /*let address = "- Lichtenberg,Josef-Orlopp-Straße: 44, 46, 48, 50, 52"
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil) {
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinate: CLLocationCoordinate2D = placemark.location!.coordinate
                mokAnnotation.coordinate = coordinate
                mokAnnotation.title = "Berlin"
                mokAnnotation.subtitle = "Straße"
             
            }
        })*/

        return mokAnnotation
    }

    func getMapData() -> String? {
        return "map data from db"
    }

}
