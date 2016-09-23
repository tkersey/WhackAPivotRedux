import XCTest
@testable import WhackAPivotRedux

class LoginViewControllerTests: XCTestCase {
    var controller: LoginViewController!
    var transitioner: FakeViewControllerTransitioner!

    override func setUp() {
        super.setUp()

        store = Store<AppState>(reducer: AppReducer(), state: nil)
        controller = UIStoryboard.loadViewController(viewControllerIdentifier: .login)

        transitioner = FakeViewControllerTransitioner()
        controller.viewControllerTransitioner = transitioner
    }

    func testNotDisplayingStatusBar() {
        XCTAssert(controller.prefersStatusBarHidden)
    }

    func testUIWebViewDelegate() {
        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()
        XCTAssert(controller.conforms(to: UIWebViewDelegate.self))
        XCTAssert(controller.webView.delegate!.isEqual(controller))
    }

    func testSubscribedToStore() {
        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()
        XCTAssert(store.subscriptions.first?.subscriber is LoginViewController)
    }

    func testUnsubscribingFromStore() {
        controller.viewWillDisappear(false)
        XCTAssert(store.subscriptions.isEmpty)
    }

    func testLoginURL() {
        XCTAssertNil(controller.loginURL)

        let state = AppState(authenticationState: FakeAuthenticationState(), challengeState: FakeChallengeState())
        controller.newState(state: state)
        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()

        XCTAssertEqual(state.loginURL, controller.loginURL)
    }

    func testLoginSuccessURL() {
        XCTAssertNil(controller.loginSuccessURL)

        let state = AppState(authenticationState: FakeAuthenticationState(), challengeState: FakeChallengeState())
        controller.newState(state: state)

        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()

        XCTAssertEqual(state.loginSuccessURL, controller.loginSuccessURL)
    }

    func testLoadingCorrectURL() {
        let webView = FakeWebView()
        controller.webView = webView

        let state = AppState(authenticationState: FakeAuthenticationState(), challengeState: FakeChallengeState())
        controller.newState(state: state)
        controller.viewDidAppear(false)

        XCTAssertEqual(webView.loadRequestCallCount, 1)
        XCTAssertEqual(webView.loadRequestArgsForCall(0).url, state.loginURL)
    }

    func testDismissingIfAlreadyLoggedIn() {
        var state = AppState(authenticationState: FakeAuthenticationState(), challengeState: FakeChallengeState())
        state.authenticationState.sessionToken = "George RR Token"

        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()

        controller.viewControllerTransitioner = transitioner
        controller.newState(state: state)

        XCTAssertEqual(transitioner.dismissCallCount, 1)
    }
}
