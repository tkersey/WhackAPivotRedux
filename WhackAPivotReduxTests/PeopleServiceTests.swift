import XCTest
@testable import WhackAPivotRedux

class PeopleServiceTests: XCTestCase {
    var service: PeopleService!
    var network: FakeNetwork!
    var returnedPeople: [Person]!

    let examplePeople = [
        ["id":1121, "first_name":"First", "last_name":"Person", "location_name":"Los Angeles", "photo_url":"First Image"],
        ["id":1379, "first_name":"Aaron", "last_name":"Hurley", "location_name":"San Francisco", "photo_url":"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/1379/IMG_2138.JPG"],
        ["id":839, "first_name":"Second", "last_name":"Person", "location_name":"Los Angeles", "photo_url":"Second Image"]
    ]

    override func setUp() {
        super.setUp()

        network = FakeNetwork()

        service = PeopleService(url: URL(string: "https://google.com")!, token: "", network: network)
    }

    func testSuccess() {
        service.getPeople(success: { people in self.returnedPeople = people}, failure: { _ in }, filter: { _ in true })

        let exampleData = try! JSONSerialization.data(withJSONObject: examplePeople, options: .prettyPrinted)
        network.requestArgsForCall(0).1(exampleData)

        let expectedPeople = [
            Person(name: "First Person", id: 1121, locationName: "Los Angeles"),
            Person(name: "Aaron Hurley", id: 1379, locationName: "San Francisco"),
            Person(name: "Second Person", id: 839, locationName: "Los Angeles")
        ]

        XCTAssertEqual(expectedPeople, returnedPeople)
    }

    func testFilteredSuccess() {
        service.getPeople(success: { people in self.returnedPeople = people}, failure: { _ in }) { person in
            person.locationName == "Los Angeles"
        }

        let exampleData = try! JSONSerialization.data(withJSONObject: examplePeople, options: .prettyPrinted)
        network.requestArgsForCall(0).1(exampleData)

        let expectedPeople = [
            Person(name: "First Person", id: 1121, locationName: "Los Angeles"),
            Person(name: "Second Person", id: 839, locationName: "Los Angeles")
        ]

        XCTAssertEqual(expectedPeople, returnedPeople)
    }

    func testFailureToHaveToken() {
        let failedService = PeopleService(url: URL(string: "https://google.com")!, token: nil, network: network)
        failedService.getPeople(success: { people in self.returnedPeople = people}, failure: { _ in }, filter: { _ in true })
        XCTAssertEqual(network.requestCallCount, 0)
    }
}
