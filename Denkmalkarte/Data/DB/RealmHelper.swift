import RealmSwift

public class RealmHelper {

    class func config() -> Realm.Configuration {

        let config = Realm.Configuration(
            schemaVersion: 0,
            migrationBlock: nil,
            objectTypes: [RealmDenkmal.self]
        )

        return config
    }
}
