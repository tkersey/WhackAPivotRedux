import XCTest
@testable import WhackAPivotRedux

class RandomizerTests: XCTestCase {
    let randomizer = Randomizer<Int>()
    var challenge: Challenge<Int>!

    override func setUp() {
        super.setUp()

        challenge = randomizer.randomSubset(ofSize: 2, from: [0,1,2], avoiding: [0, 2])
    }

    func testRandomSubset() {
        XCTAssertEqual(challenge.choices[challenge.target], 1)
    }
}
