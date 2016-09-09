import XCTest
@testable import WhackAPivotRedux

class ChallengeReducerTests: XCTestCase {
    let person = Person(name: "Person", id: 0, locationName: "")
    let anotherPerson = Person(name: "Person2", id: 2, locationName: "")

    func testInitialization() {
        let state = challengeReducer(state: FakeChallengeState(), action: ReSwiftInit())
        XCTAssertEqual(state.previouslyTargeted, Set<Person>())
    }

    func testSettingPeople() {
        let action = SetPeople(people: [person])
        let state = challengeReducer(state: FakeChallengeState(), action: action)
        XCTAssertEqual(state.people!, [person])
    }

    func testCreatingAChallenge() {
        var fakeState = FakeChallengeState()
        fakeState.previouslyTargeted = Set<Person>()
        fakeState.people = [person, anotherPerson]

        let action = CreateChallenge(per: 2)
        let state = challengeReducer(state: fakeState, action: action)

        XCTAssertEqual(state.previouslyTargeted?.count, 1)
        XCTAssertEqual(state.perChallenge!, 2)
        XCTAssertEqual(state.challenge!.choices.count, 2)
        XCTAssertGreaterThanOrEqual(state.challenge!.target, 0)
        XCTAssertLessThanOrEqual(state.challenge!.target, 1)
    }

    func testUpdatingAChallengeWithACorrectSelection() {
        let yetAnotherPerson = Person(name: "Person3", id: 3, locationName: "")

        var fakeState = FakeChallengeState()
        fakeState.previouslyTargeted = Set<Person>()
        fakeState.people = [person, anotherPerson, yetAnotherPerson]

        let createAction = CreateChallenge(per: 3)
        let challengeState = challengeReducer(state: fakeState, action: createAction)

        XCTAssertEqual(challengeState.previouslyTargeted?.count, 1)

        let action = UpdateChallenge(selected: challengeState.challenge!.target)
        let state = challengeReducer(state: challengeState, action: action)

        XCTAssert(state.correctSelection!)
        XCTAssertEqual(state.previouslyTargeted?.count, 2)
    }

    func testUpdatingAChallengeWithAWrongSelection() {
        let yetAnotherPerson = Person(name: "Person3", id: 3, locationName: "")

        var fakeState = FakeChallengeState()
        fakeState.previouslyTargeted = Set<Person>()
        fakeState.people = [person, anotherPerson, yetAnotherPerson]

        let createAction = CreateChallenge(per: 2)
        let challengeState = challengeReducer(state: fakeState, action: createAction)

        let action = UpdateChallenge(selected: 3)
        let state = challengeReducer(state: challengeState, action: action)

        XCTAssertFalse(state.correctSelection!)
    }

    func testUpdatingAChallengeWhenNoChallengeExists() {
        let fakeState = FakeChallengeState()
        XCTAssertNil(fakeState.challenge)

        let action = UpdateChallenge(selected: 0)
        let state = challengeReducer(state: fakeState, action: action)
        XCTAssertNil(state.challenge)
    }
}
