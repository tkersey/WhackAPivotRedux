import XCTest
@testable import WhackAPivotRedux

class ChallengeServiceTests: XCTestCase {
    var service: ChallengeService!
    var randomizer: FakeRandomizer!
    var challenge: Challenge!
    var stubbedChallenge: Challenge!

    let people = [
        Person(name: "Joe", id: 0, image: UIImage(), locationName: ""),
        Person(name: "Steve", id: 1, image: UIImage(), locationName: ""),
        Person(name: "Steve2", id: 2, image: UIImage(), locationName: ""),
        Person(name: "Steve3", id: 3, image: UIImage(), locationName: ""),
        Person(name: "Steve4", id: 4, image: UIImage(), locationName: ""),
        Person(name: "Steve5", id: 5, image: UIImage(), locationName: ""),
        Person(name: "Steve6", id: 6, image: UIImage(), locationName: ""),
        Person(name: "Steve7", id: 7, image: UIImage(), locationName: ""),
        Person(name: "Steve8", id: 8, image: UIImage(), locationName: "")
    ]

    override func setUp() {
        super.setUp()

        stubbedChallenge = Challenge(choices: [people[1]], target: 0)

        randomizer = FakeRandomizer()
        service = ChallengeService(randomizer: randomizer)
        service.newGame(people: people, perChallenge: 6)

        randomizer.randomSubsetReturns(stubbedValues: stubbedChallenge)
        challenge = service.getChallenge()!
    }

    func testReceivingChallengeFromRandomizer() {
        XCTAssertEqual(randomizer.randomSubsetCallCount, 1)

        let args = randomizer.randomSubsetArgsForCall(0)
        XCTAssertEqual(args.0, 6)
        XCTAssertEqual(args.1, people)
        XCTAssertEqual(args.2, [])

        XCTAssertEqual(challenge, stubbedChallenge)
    }

    func testReusingAChallengeWithPeopleToAvoid() {
        let personToAvoid = stubbedChallenge.choices[challenge.target]
        let anotherStubbedChallenge = Challenge(choices: [people[0]], target: 0)

        randomizer.randomSubsetReturns(stubbedValues: anotherStubbedChallenge)
        challenge = service.getChallenge()!

        let args = randomizer.randomSubsetArgsForCall(1)
        XCTAssertEqual(args.0, 6)
        XCTAssertEqual(args.1, people)
        XCTAssertEqual(args.2, [personToAvoid])
    }

    func testReturningNilWhenAllPeopleHaveBeenChallenged() {
        for index in [0,2,3,4,5,6,7,8] {
            randomizer.randomSubsetReturns(stubbedValues: Challenge(choices: [people[index]], target: 0))
            _ = service.getChallenge()
        }

        XCTAssertNil(service.getChallenge())
    }
}
