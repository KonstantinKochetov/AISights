import Foundation
import FirebaseDatabase

class ApiHelperImpl: ApiHelper {

    var ref: DatabaseReference

    public init(ref: DatabaseReference) {
        self.ref = ref
    }

    func getFirebaseData(success: @escaping ([[String: AnyObject]]) -> Void,
                         failure: @escaping (Error) -> Void) {

        ref.observe(DataEventType.value, with: { (snapshot) in
            let denkmaleSnapshot = snapshot.value as? [String: AnyObject] ?? [:]
            let snapshots = denkmaleSnapshot["denkmale"]
            success(snapshots as? [[String: AnyObject]] ?? [[String: AnyObject]]())
        })
    }
}
