import UIKit
import ReSwift

class People {
    var service: PeopleServiceType

    init(service: PeopleServiceType) {
        self.service = service
    }
}

// MARK: - Static
extension People {
    static func load() -> [Person]? {
        if let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            var people = [Person]()
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: "\(documentsPath)/people.json"))
                let json = try JSONSerialization.jsonObject(with: data) as? [[String:AnyObject]]
                json?.forEach { dict in
                    if let id = dict["id"] as? Int, let image = UIImage(contentsOfFile: "\(documentsPath)/\(id).png"), let name = dict["name"] as? String, let locationName = dict["location_name"] as? String {
                        people.append(Person(name: name, id: id, locationName: locationName, image: image))
                    }
                }
            } catch {
                return nil
            }
            return people
        } else {
            return nil
        }
    }

    static func save(people: [Person]) {
        if let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            do {
                let people: [[String:AnyObject]] = people.map { person -> [String:AnyObject] in
                    if let data = UIImagePNGRepresentation(person.image) {
                        do {
                            try data.write(to: URL(fileURLWithPath: "\(documentsPath)/\(person.id).png"))
                        } catch {
                            print("\nFailed to store avatar for person: \(error.localizedDescription)\n")
                        }
                    }
                    return ["id": person.id as AnyObject, "name": person.name as AnyObject, "location_name": person.locationName as AnyObject]
                }

                let data = try JSONSerialization.data(withJSONObject: people, options: .prettyPrinted)
                try data.write(to: URL(fileURLWithPath: "\(documentsPath)/people.json"), options: .noFileProtection)
            } catch {
                print("\nFailed to store people: \(error.localizedDescription)\n")
            }
        }
    }
}

// MARK: - Fetch
extension People {
    func fetch(state: AppState, store: Store<AppState>) -> Action? {
        service.url = state.peopleURL
        service.token = state.authenticationState.sessionToken
        service.getPeople(success: { people in
            self.service.dispatch.mainAsync {
                store.dispatch(SetPeople(people: people))
            }
            }, failure: { _ in
            }, filter: service.filter)

       return nil
    }
}
