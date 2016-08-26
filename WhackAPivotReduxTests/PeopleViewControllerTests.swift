import XCTest
@testable import WhackAPivotRedux

class PeopleViewControllerTests: XCTestCase {
    var controller: PeopleViewController!
    var viewControllerTransitioner: FakeViewControllerTransitioner!
    var peopleService: FakePeopleService!
    var peopleStore: FakePeopleStore!

    let expectedPeople = [
        Person(name: "First Person", id: 1121, locationName: "Los Angeles"),
        Person(name: "Second Person", id: 839, locationName: "Los Angeles")
    ]

    override func setUp() {
        super.setUp()

        viewControllerTransitioner = FakeViewControllerTransitioner()
        peopleService = FakePeopleService()
        peopleStore = FakePeopleStore()

        controller = UIStoryboard.loadViewController(viewControllerIdentifier: .people)
        controller.peopleService = peopleService
        controller.peopleStore = peopleStore

        _ = controller.view
        controller.viewControllerTransitioner = viewControllerTransitioner

        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()
    }

    func testSuccess() {
        peopleService.getPeopleArgsForCall(0).0(expectedPeople)

        XCTAssertEqual(peopleStore.people!, expectedPeople)

        XCTAssertEqual(viewControllerTransitioner.performSegueCallCount, 1)
        XCTAssertEqual(viewControllerTransitioner.performSegueArgsForCall(0).0, "segueToGame")
    }

    func testFailure() {
        peopleService.getPeopleArgsForCall(0).1(NSError(domain: "", code: 0, userInfo: nil))

        XCTAssert(peopleStore.people!.isEmpty)

        XCTAssertEqual(viewControllerTransitioner.performSegueCallCount, 1)
        XCTAssertEqual(viewControllerTransitioner.performSegueArgsForCall(0).0, "segueToLogin")
    }
}
