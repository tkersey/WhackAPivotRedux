import UIKit

class PeopleStore: PeopleStoreType {
    private let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    var people: [Person]? {
        get {
            if let documentsPath = documentsPath {
                var _people = [Person]()
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: "\(documentsPath)/people.json"))
                    let json = try JSONSerialization.jsonObject(with: data) as? [[String:AnyObject]]
                    json?.forEach { dict in
                        if let id = dict["id"] as? Int, let image = UIImage(contentsOfFile: "\(documentsPath)/\(id).png"), let name = dict["name"] as? String {
                            _people.append(Person(name: name, id: id, image: image))
                        }
                    }
                } catch {
                    return nil
                }
                return _people
            } else {
                return nil
            }
        }

        set {
            if let newPeople = newValue {
                do {
                    let people: [[String:AnyObject]] = try newPeople.map { person -> [String:AnyObject] in
                        if let data = UIImagePNGRepresentation(person.image) {
                            try data.write(to: URL(fileURLWithPath: "\(documentsPath)/\(person.id).png"))
                        }
                        return ["id": person.id as AnyObject, "name": person.name as AnyObject]
                    }

                    let data = try JSONSerialization.data(withJSONObject: people, options: .prettyPrinted)
                    try data.write(to: URL(fileURLWithPath: "\(documentsPath)/people.json"), options: .noFileProtection)
                } catch {
                    print("\nFailed to store people\n")
                }
            }
        }
    }
}
