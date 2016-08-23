import UIKit

struct Person : Hashable {
    let name: String
    let id: Int
    let image: UIImage
    let locationName: String

    var hashValue: Int {
        get {
            return "\(id)\(name)".hashValue
        }
    }

    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id && lhs.locationName == rhs.locationName
    }
}
