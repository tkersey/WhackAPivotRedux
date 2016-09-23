import Foundation

struct PeopleService: PeopleServiceType {
    var network: NetworkType = Network()
    var url: URL?
    var token: String?
    var filter: (Person) -> Bool
    var dispatch: DispatchType = Dispatch()

    func getPeople(success: @escaping ([Person]) -> Void, failure: @escaping (Error) -> Void, filter: @escaping (Person) -> Bool) {
        guard let token = token else {
            failure(NSError(domain: "PeopleServiceGetPeople", code: 0, userInfo: [:]))
            return
        }

        if let url = url {
            var request = URLRequest(url: url)
            request.setValue("_pivots-two_session=\(token)", forHTTPHeaderField: "Cookie")
            network.request(with: request, success: { data in
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as? [[String:AnyObject]]
                    var people = [Person]()
                    json?.forEach { person in
                        if let person = Person(json: person), filter(person) {
                            people.append(person)
                            print(person.name)
                        }
                    }
                    success(people)
                } catch {}
                }, failure: failure)
        }
    }
}

extension PeopleService {
    init(url: URL?, token: String?, network: NetworkType = Network(), filter: @escaping (Person) -> Bool = { _ in true }) {
        self.network = network
        self.url = url
        self.token = token
        self.filter = filter
    }

    init(filter: @escaping (Person) -> Bool = { _ in true }) {
        self.init(url: nil, token: nil, network: Network(), filter: filter)
    }
}
