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

// MARK: - JSON
extension Person {
    init?(json: [String:AnyObject]) {
        guard let firstName = json["first_name"] as? String, let lastName = json["last_name"], let id = json["id"] as? Int, let locationName = json["location_name"] as? String else { return nil }
        self.name = "\(firstName) \(lastName)"
        self.id = id
        self.locationName = locationName

        if let photoURL = json["photo_url"] as? String, let imageURL = URL(string: photoURL), let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = UIImage()
        }
    }
}
