import XCTest
@testable import WhackAPivotRedux
@testable import ReSwift
@testable import ReSwiftRouter

class AppDelegateTests: XCTestCase {
    var appDelegate: AppDelegate!
    var reducer: FakeAppReducer!

    override func setUp() {
        super.setUp()
        appDelegate = AppDelegate()
        reducer = FakeAppReducer()
        appDelegate.reducer = reducer
    }

    func testLoggedIn() {
        var authenticationState = FakeAuthenticationState()
        authenticationState.sessionToken = "String content doesn't matter"

        let state = AppState(navigationState: NavigationState(), authenticationState: authenticationState, challengeState: FakeChallengeState())
        reducer.handleActionReturns(stubbedValues: state)

        _ = appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

        XCTAssertEqual(2, reducer.handleActionCallCount)
        XCTAssert(reducer.handlActionArgsForCall(1).0 is SetRouteAction)
        XCTAssertEqual(["game"], (reducer.handlActionArgsForCall(1).0 as! SetRouteAction).route)
    }

    func testNotLoggedIn() {
        let state = AppState(navigationState: NavigationState(), authenticationState: FakeAuthenticationState(), challengeState: FakeChallengeState())
        reducer.handleActionReturns(stubbedValues: state)

        _ = appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

        XCTAssertEqual(2, reducer.handleActionCallCount)
        XCTAssert(reducer.handlActionArgsForCall(1).0 is SetRouteAction)
        XCTAssertEqual(["game", "login"], (reducer.handlActionArgsForCall(1).0 as! SetRouteAction).route)
    }
}
