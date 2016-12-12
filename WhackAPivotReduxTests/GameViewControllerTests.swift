import XCTest
import UIKit
@testable import WhackAPivotRedux
@testable import ReSwift
import ReSwiftRouter

class GameViewControllerTests: XCTestCase {
    var controller: GameViewController!
    var peopleService: FakePeopleService!

    let people = [
        Person(name: "Joe", id: 0, locationName: ""),
        Person(name: "Steve", id: 1, locationName: ""),
        Person(name: "Steve2", id: 2, locationName: ""),
        Person(name: "Steve3", id: 3, locationName: ""),
        Person(name: "Steve4", id: 4, locationName: ""),
        Person(name: "Steve5", id: 5, locationName: "")
    ]

    override func setUp() {
        super.setUp()

        store = Store<AppState>(reducer: AppReducer().handleAction, state: nil)

        peopleService = FakePeopleService()

        controller = UIStoryboard.loadViewController(viewControllerIdentifier: .game)
        controller.peopleService = peopleService
        _ = controller.view
    }

    func testNotDisplayingStatusBar() {
        XCTAssert(controller.prefersStatusBarHidden)
    }

    func testSubscribedToStore() {
        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()
        XCTAssert(store.subscriptions.first?.subscriber is GameViewController)
    }

    func testUnsubscribingFromStore() {
        controller.viewWillDisappear(false)
        XCTAssert(store.subscriptions.isEmpty)
    }

    func testResultLabelSetup() {
        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()

        XCTAssert(controller.resultLabel.isHidden)
        XCTAssertEqual("Incorrect!", controller.resultLabel.text)
    }

    func testFetchingPeopleIfChallengeHasNone() {
        let reducer = FakeAppReducer()
        var authenticationState = FakeAuthenticationState()
        authenticationState.sessionToken = "GotzATok"
        let state = AppState(navigationState: NavigationState(), authenticationState: authenticationState, challengeState: FakeChallengeState())

        reducer.handleActionReturns(stubbedValues: state)
        peopleService.getPeopleSuccessStub = people

        store = Store<AppState>(reducer: reducer.handleAction, state: state)
        controller.newState(state: state)

        XCTAssert(reducer.handlActionArgsForCall(0).0 is SetPeople)
        XCTAssertEqual(people, (reducer.handlActionArgsForCall(0).0 as! SetPeople).people)
    }

    func testReadyForAChallenge() {
        let reducer = FakeAppReducer()
        var authenticationState = FakeAuthenticationState()
        authenticationState.sessionToken = "GotzATok"
        var challengeState = FakeChallengeState()
        challengeState.people = people
        let state = AppState(navigationState: NavigationState(), authenticationState: authenticationState, challengeState: challengeState)

        reducer.handleActionReturns(stubbedValues: state)

        store = Store<AppState>(reducer: reducer.handleAction, state: state)
        controller.newState(state: state)

        XCTAssert(reducer.handlActionArgsForCall(0).0 is CreateChallenge)
        XCTAssertEqual(6, (reducer.handlActionArgsForCall(0).0 as! CreateChallenge).per)
    }

    func testChallenge() {
        var challengeState = FakeChallengeState()
        challengeState.previouslyTargeted = Set<Person>()
        challengeState.people = people
        challengeState = challengeReducer(state: challengeState, action: CreateChallenge(per: 2)) as! FakeChallengeState
        let challenge = challengeState.challenge!

        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()

        let state = AppState(navigationState: NavigationState(), authenticationState: FakeAuthenticationState(), challengeState: challengeState)
        controller.newState(state: state)

        for (index, person) in challenge.choices.enumerated() {
            XCTAssertEqual(person.image, controller.buttons[index].backgroundImage(for: .normal))
        }

        XCTAssertEqual(challenge.choices[challenge.target].name, controller.nameLabel.text)
    }

    func testCorrectChallengeSelection() {
        var challengeState = FakeChallengeState()
        challengeState.previouslyTargeted = Set<Person>()
        challengeState.people = people
        challengeState = challengeReducer(state: challengeState, action: CreateChallenge(per: 2)) as! FakeChallengeState
        challengeState.correctSelection = true

        let state = AppState(navigationState: NavigationState(), authenticationState: FakeAuthenticationState(), challengeState: challengeState)
        controller.newState(state: state)

        controller.buttons[challengeState.challenge!.target].sendActions(for: .touchUpInside)

        XCTAssert(controller.resultLabel.isHidden)
    }

    func testIncorrectChallengeSelection() {
        var challengeState = FakeChallengeState()
        challengeState.previouslyTargeted = Set<Person>()
        challengeState.people = people
        challengeState = challengeReducer(state: challengeState, action: CreateChallenge(per: 2)) as! FakeChallengeState
        challengeState.correctSelection = false

        let state = AppState(navigationState: NavigationState(), authenticationState: FakeAuthenticationState(), challengeState: challengeState)
        controller.newState(state: state)

        controller.buttons[challengeState.challenge!.target].sendActions(for: .touchUpInside)

        XCTAssertFalse(controller.resultLabel.isHidden)
    }

    func testUpdateChallenge() {
        let reducer = FakeAppReducer()
        let state = AppState(navigationState: NavigationState(), authenticationState: FakeAuthenticationState(), challengeState: FakeChallengeState())
        reducer.handleActionReturns(stubbedValues: state)

        store = Store<AppState>(reducer: reducer.handleAction, state: state)
        controller.buttons[0].sendActions(for: .touchUpInside)

        XCTAssert(reducer.handlActionArgsForCall(0).0 is UpdateChallenge)
        XCTAssertEqual(0, (reducer.handlActionArgsForCall(0).0 as! UpdateChallenge).selected)
    }
}
