import XCTest
@testable import WhackAPivotRedux

class PeopleServiceTests: XCTestCase {
    var service: PeopleServiceType!
    var network: FakeNetwork!
    var tokenStore: FakeTokenStore!
    var urlProvider: FakeURLProvider!
    var returnedPeople: [Person]!

    let examplePeople = [
        ["id":1121, "first_name":"First", "last_name":"Person", "location_name":"Los Angeles", "photo_url":"First Image"],
        ["id":1379, "first_name":"Aaron", "last_name":"Hurley", "location_name":"San Francisco", "photo_url":"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/1379/IMG_2138.JPG"],
        ["id":839, "first_name":"Second", "last_name":"Person", "location_name":"Los Angeles", "photo_url":"Second Image"]
    ]

    let expectedPeople = [
        Person(name: "First Person", id: 1121, image: UIImage(), locationName: "Los Angeles"),
        Person(name: "Aaron Hurley", id: 1379, image: UIImage(), locationName: "San Francisco"),
        Person(name: "Second Person", id: 839, image: UIImage(), locationName: "Los Angeles")
    ]

    override func setUp() {
        super.setUp()

        network = FakeNetwork()

        tokenStore = FakeTokenStore()
        tokenStore.token = "FakeTokenString123"

        urlProvider = FakeURLProvider()
        urlProvider.peopleURLReturns(stubbedValues: URL(string: "http://example.com"))

        service = PeopleService(network: network, tokenStore: tokenStore, urlProvider: urlProvider)
        service.getPeople(success: { people in self.returnedPeople = people}, failure: { _ in })
    }

    func testSuccess() {
        let exampleData = try! JSONSerialization.data(withJSONObject: examplePeople, options: .prettyPrinted)
        network.requestArgsForCall(callIndex: 0).1(exampleData)

        XCTAssertEqual(expectedPeople, returnedPeople)
    }
}
