import Foundation
import MapKit

class DbHelperImpl: DbHelper {

    func getPointAnnotation() -> [MKAnnotation]? {

        let parser = Parser()

        if let mockAnno = parser.readXML() {
            return mockAnno
        }
        return nil
    }

}
