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

    func like(id: String,
              userId: String,
              success: @escaping (() -> Void),
              failure: @escaping ((Error) -> Void)) {

        ref.child("denkmale").child(id).child("userId").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            let dict = snapshot.value as? [String : AnyObject] ?? [:]
            if dict.isEmpty { // if denkmal does not exist yed
                let newRef2 = self.ref.child("denkmale")
                newRef2.child(id).setValue(["likes": 1, "userId": [userId: true]])
            } else {
                let value = dict[userId] as? Bool
                if let value = value {
                    if value == false { // if user did not like it yet then increment
                        let newRef = self.ref.child("denkmale").child(id).child("likes")
                        newRef.observeSingleEvent(of: .value, with: { snapshot in
                            let value2 = snapshot.value ?? -9
                            let value = value2 as? NSNumber
                            if let value = value {
                                if value != -9 {
                                    let finalValue = value.int32Value + 1
                                    newRef.setValue(finalValue)
                                }
                            }
                        })
                    }
                }
            }
        })
    }
}
