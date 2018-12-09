import Foundation
import FirebaseDatabase

class ApiHelperImpl: ApiHelper {

    func getFirebaseData(success: @escaping (NSArray) -> Void,
                         failure: @escaping (Error) -> Void) {

        var ref: DatabaseReference!
        ref = Database.database().reference() // TODO use injector

        ref.observe(DataEventType.value, with: { (snapshot) in
            let denkmaleSnapshot = snapshot.value as? [String : AnyObject] ?? [:]
            let snapshots = denkmaleSnapshot["denkmale"]
            success(snapshots as? NSArray ?? NSArray())
        })

//        ref.observeSingleEvent(of: .value, with: { snapshot in
//            let snapshots = snapshot.value as? [String: AnyObject] ?? [:]
//            success(snapshots["denkmale"] as? [String: AnyObject] ?? [:])
//        }) { error in
//            failure(error)
//        }
    }
}
