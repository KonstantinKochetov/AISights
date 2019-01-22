import Foundation
import FirebaseDatabase
import FirebaseStorage

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

    func upload(_ image: UIImage, withMonumentId monumentId: String, success: @escaping (() -> Void), failure: @escaping ((Error) -> Void)) {
        image.compress { data, width, height, error in
            if let error = error {
                failure(error)
                return
            }

            let uuid = UUID.init().uuidString

            let storageReference = Storage
                .storage()
                .reference(withPath: "user-uploads")
                .child(uuid)

            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            let uploadTask = storageReference.putData(data!, metadata: metadata) { storageMetadata, error in
                if let error = error {
                    print(error)
                }

                if let storageMetadata = storageMetadata,
                    let name = storageMetadata.name {
                    self.saveImageInDatabase(withMonumentId: monumentId, imageId: name)
                }
            }

            uploadTask.observe(.progress) { storageTaskSnapshot in
                if let progress = storageTaskSnapshot.progress {

                    let completedUnitCount = Float(progress.completedUnitCount)
                    let totalUnitCount = Float(progress.totalUnitCount)
                    let progress = completedUnitCount / totalUnitCount

                    print(progress)
                }
            }
        }
    }

    private func saveImageInDatabase(withMonumentId monumentId: String, imageId: String) {
        let ref = self.ref.child("denkmale").child(monumentId).child("images")
        ref.childByAutoId().setValue(imageId)
    }
}
