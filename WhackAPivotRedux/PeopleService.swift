import Foundation

struct PeopleService: PeopleServiceType {
    var network: NetworkType!
    var tokenStore: TokenStoreType!
    var urlProvider: URLProviderType!

    func getPeople(success: @escaping ([Person]) -> Void, failure: @escaping (Error) -> Void) {
        if let url = urlProvider.peopleURL() {
            let request = URLRequest(url: url)
            network.request(with: request, success: { data in
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as? [[String:AnyObject]]
                    var people = [Person]()
                    json?.forEach { person in
                        if let person = Person(json: person) {
                            people.append(person)
                        }
                    }
                    success(people)
                } catch {}
                }, failure: failure)
        }
    }
}
