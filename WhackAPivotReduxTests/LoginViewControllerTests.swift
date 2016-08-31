import XCTest
import WebKit
@testable import WhackAPivotRedux

class LoginViewControllerTests: XCTestCase {
    var controller: LoginViewController!
    var viewControllerTransitioner: FakeViewControllerTransitioner!
    var peopleStore: PeopleStoreType!
    var tokenStore: TokenStoreType!

    override func setUp() {
        super.setUp()

        viewControllerTransitioner = FakeViewControllerTransitioner()
        peopleStore = FakePeopleStore()
        tokenStore = FakeTokenStore()

        controller = UIStoryboard.loadViewController(viewControllerIdentifier: .login)

        controller.peopleStore = peopleStore
        controller.tokenStore = tokenStore
        controller.urlProvider = URLProvider(baseURL: "http://cashcats.biz")

        _ = controller.view
        controller.viewControllerTransitioner = viewControllerTransitioner
    }

    func testNotDisplayingStatusBar() {
        XCTAssert(controller.prefersStatusBarHidden)
    }

    func testViewContainsWebView() {
        XCTAssert(controller.view.subviews.contains(controller.webView))
    }

    func testWebViewFrame() {
        XCTAssertEqual(controller.webView.frame, controller.view.frame)
    }

    func testUIWebViewDelegate() {
        XCTAssert(controller.conforms(to: UIWebViewDelegate.self))
        XCTAssert(controller.webView.delegate!.isEqual(controller))
    }

    func testWhenPeopleArePresentInPeopleStore() {
        peopleStore.people = [Person(name: "", id: 0, locationName: "")]
        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()

        XCTAssertEqual(viewControllerTransitioner.performSegueCallCount, 1)
        XCTAssertEqual(viewControllerTransitioner.performSegueArgsForCall(0).0, "segueToGame")
    }

    func testWhenATokenIsPresentInTokenStore() {
        tokenStore.token = "fake token"
        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()

        XCTAssertEqual(viewControllerTransitioner.performSegueCallCount, 1)
        XCTAssertEqual(viewControllerTransitioner.performSegueArgsForCall(0).0, "PeopleViewController")
    }

    // TODO - Figure out how to wait for url to load
    func testSavingToTokenStoreWhenAuthTokenIsPresent() {
//        controller.webView.loadRequest(URLRequest(url: controller.urlProvider.url(forPath: "/mobile_success")!))
//        let cookie = HTTPCookie(properties: [.path:"\\",
//                            .originURL: controller.urlProvider.url(forPath: "")!,
//                            .name:"_pivots-two_session",
//                            .value:"foo"])!
//        HTTPCookieStorage.shared.setCookie(cookie)
//        controller.webViewDidFinishLoad(controller.webView)
//        XCTAssertEqual(controller.tokenStore.token, cookie.value)
//
//        XCTAssertEqual(viewControllerTransitioner.performSegueCallCount, 1)
//        XCTAssertEqual(viewControllerTransitioner.performSegueArgsForCall(0).0, "PeopleViewController")
//
//        HTTPCookieStorage.shared.deleteCookie(cookie)
    }

    func testNotSavingTokenWhenAuthTokenIsNotPresent() {
        controller.webView.loadRequest(URLRequest(url: controller.urlProvider.url(forPath: "/mobile_success")!))
        controller.webViewDidFinishLoad(controller.webView)
        XCTAssertNil(controller.tokenStore.token)
    }
}
