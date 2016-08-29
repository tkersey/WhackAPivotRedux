import XCTest
@testable import WhackAPivotRedux

class RandomizerTests: XCTestCase {
    let randomizer = Randomizer()
    var challenge: Challenge!

    let people = [
        Person(name: "P1", id: 0, locationName: ""),
        Person(name: "P2", id: 1, locationName: ""),
        Person(name: "P3", id: 2, locationName: "")
    ]

    override func setUp() {
        super.setUp()

        challenge = randomizer.randomSubset(ofSize: 2, from: people, avoiding: [people[0], people[2]])
    }

    func testRandomSubset() {
        XCTAssertEqual(challenge.choices[challenge.target], people[1])
    }
}