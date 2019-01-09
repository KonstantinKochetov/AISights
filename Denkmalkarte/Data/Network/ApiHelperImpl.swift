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

        ref.child("denkmale").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            debugPrint(snapshot)
            let dict = snapshot.value as? [String: AnyObject] ?? [:]
            if dict.isEmpty { // if denkmal does not exist yet
                self.createDenkmalAndSetOneLike(id: id, userId: userId)
            } else {
                let value = dict.values.filter { ($0 as? [String: AnyObject] ?? [String: AnyObject]())[userId] != nil  }
                    if value.isEmpty { // if user did not like it yet then increment
                        self.incrementLikes(id: id, userId: userId)
                    } else { // already liked
                        // do nothing
                    }
            }
        })
    }

    private func createDenkmalAndSetOneLike(id: String, userId: String) {
        let newRef2 = self.ref.child("denkmale")
        newRef2.child(id).setValue(["likes": 1, UUID().uuidString: [userId: true]])
    }

    private func incrementLikes(id: String, userId: String) {
        let ref = self.ref.child("denkmale").child(id).child("likes")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let value2 = snapshot.value ?? -9
            let value = value2 as? NSNumber
            if let value = value {
                if value != -9 {
                    let finalValue = value.int32Value + 1
                    ref.setValue(finalValue)
                    let key = self.ref.child("denkmale").child(id).childByAutoId().key
                    let user = [userId: true]
                    let childUpdate = [key: user]
                    self.ref.child("denkmale").child(id).updateChildValues(childUpdate)
                }
            }
        })
    }
}
