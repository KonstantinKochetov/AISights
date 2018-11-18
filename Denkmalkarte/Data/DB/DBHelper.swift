import MapKit
protocol DbHelper {
    
    func saveAll(_ denkmale: [Denkmal]) throws
    
    func save(_ event: Denkmal) throws
    
    func getAll() throws -> [Denkmal]
    
    func clean() throws
    
    func getPointAnnotation() -> [MKAnnotation]?
    
}
