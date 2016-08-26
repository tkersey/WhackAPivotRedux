import XCTest
import UIKit
@testable import WhackAPivotRedux

class GameViewControllerTests: XCTestCase {
    var controller: GameViewController!
    var challengeService: FakeChallengeService!
    var presenter: FakePersonPresenter!
    var store: FakePeopleStore!

    let people = [
        Person(name: "Joe", id: 0, locationName: ""),
        Person(name: "Steve", id: 1, locationName: ""),
        Person(name: "Steve2", id: 2, locationName: ""),
        Person(name: "Steve3", id: 3, locationName: ""),
        Person(name: "Steve4", id: 4, locationName: ""),
        Person(name: "Steve5", id: 5, locationName: "")
    ]

    let morePeople = [
        Person(name: "Joe7", id: 7, locationName: ""),
        Person(name: "Steve7", id: 70, locationName: ""),
        Person(name: "Steve27", id: 27, locationName: ""),
        Person(name: "Steve37", id: 37, locationName: ""),
        Person(name: "Steve47", id: 47, locationName: ""),
        Person(name: "Steve57", id: 57, locationName: "")
    ]

    override func setUp() {
        super.setUp()

        store = FakePeopleStore()
        store.people = people

        challengeService = FakeChallengeService()
        challengeService.getChallengeReturns(stubbedValues: Challenge(choices: people, target: 1))
        presenter = FakePersonPresenter()

        controller = UIStoryboard.loadViewController(viewControllerIdentifier: .game)
        controller.peopleStore = store
        controller.challengeService = challengeService
        controller.personPresenter = presenter

        _ = controller.view
    }
    func testDisplayingTheCorrectPeople() {
        XCTAssertEqual(presenter.displayCallCount, 6)
        XCTAssertEqual(presenter.displayArgsForCall(0).0, people[0])
        XCTAssertEqual(presenter.displayArgsForCall(1).0, people[1])
        XCTAssertEqual(presenter.displayArgsForCall(2).0, people[2])
        XCTAssertEqual(presenter.displayArgsForCall(3).0, people[3])
        XCTAssertEqual(presenter.displayArgsForCall(4).0, people[4])
        XCTAssertEqual(presenter.displayArgsForCall(5).0, people[5])
    }

    func testSettingNameLabelOfTargetPerson() {
        XCTAssertEqual(controller.nameLabel.text, "Steve")
    }

    func testHiddenResultLabel() {
        XCTAssert(controller.resultLabel.isHidden)
    }

    func testClickingOnTheWrongPersontToRefreshPeople() {
        challengeService.getChallengeReturns(stubbedValues: Challenge(choices: morePeople, target: 1))
        controller.buttons[1].sendActions(for: .touchUpInside)

        XCTAssertEqual(presenter.displayCallCount, 12)
        XCTAssertEqual(presenter.displayArgsForCall(6).0, morePeople[0])
        XCTAssertEqual(presenter.displayArgsForCall(7).0, morePeople[1])
        XCTAssertEqual(presenter.displayArgsForCall(8).0, morePeople[2])
        XCTAssertEqual(presenter.displayArgsForCall(9).0, morePeople[3])
        XCTAssertEqual(presenter.displayArgsForCall(10).0, morePeople[4])
        XCTAssertEqual(presenter.displayArgsForCall(11).0, morePeople[5])

        XCTAssertEqual(controller.nameLabel.text, "Steve7")
    }

    func testClickingIncorrectImageDisplaysIncorrectAndThenClickCorrectImage() {
        controller.buttons[0].sendActions(for: .touchUpInside)

        XCTAssertEqual(controller.resultLabel.text, "Incorrect!")
        XCTAssertFalse(controller.resultLabel.isHidden)

        controller.buttons[1].sendActions(for: .touchUpInside)
        XCTAssert(controller.resultLabel.isHidden)
    }

    func testCorrectlyClickingLastImageOfSet() {
        presenter.reset()
        challengeService.getChallengeReturns(stubbedValues: nil)
        controller.buttons[1].sendActions(for: .touchUpInside)

        XCTAssertEqual(presenter.displayCallCount, 0)
    }
}
