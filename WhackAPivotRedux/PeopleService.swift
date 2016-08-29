import Foundation

struct PeopleService: PeopleServiceType {
    var network: NetworkType = Network()
    var tokenStore: TokenStoreType = TokenStore()
    var urlProvider: URLProviderType = URLProvider(baseURL: "https://pivots.pivotallabs.com")

    func getPeople(success: @escaping ([Person]) -> Void, failure: @escaping (Error) -> Void, filter: @escaping (Person) -> Bool = { _ in true }) {
        guard let token = tokenStore.token else {
            failure(NSError(domain: "PeopleServiceGetPeople", code: 0, userInfo: [:]))
            return
        }

        if let url = urlProvider.peopleURL() {
            var request = URLRequest(url: url)
            request.setValue("_pivots-two_session=\(token)", forHTTPHeaderField: "Cookie")
            network.request(with: request, success: { data in
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as? [[String:AnyObject]]
                    var people = [Person]()
                    json?.forEach { person in
                        if let person = Person(json: person), filter(person) {
                            people.append(person)
                        }
                    }
                    success(people)
                } catch {}
                }, failure: failure)
        }
    }
}
