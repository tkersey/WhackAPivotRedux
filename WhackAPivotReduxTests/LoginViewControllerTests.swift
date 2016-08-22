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

        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "LoginViewControllerIdentifier") as! LoginViewController

        controller.peopleStore = peopleStore
        controller.tokenStore = tokenStore
        controller.urlProvider = URLProvider(baseURL: "http://cashcats.biz")

        _ = controller.view
        controller.viewControllerTransitioner = viewControllerTransitioner
    }

    func testViewContainsWebView() {
        XCTAssert(controller.view.subviews.contains(controller.webview))
    }

    func testWebViewFrame() {
        XCTAssertEqual(controller.webview.frame, controller.view.frame)
    }

    func testUIWebViewDelegate() {
        XCTAssert(controller.conforms(to: WKNavigationDelegate.self))
        controller.webview.navigationDelegate!.isEqual(controller)
    }

    func testWhenPeopleArePresentInPeopleStore() {
        peopleStore.people = [Person(name: "", id: 0, image: UIImage())]
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

    func testLoadingRequestIfTokenNotPresent() {
        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()

        XCTAssertEqual(controller.webview.url?.absoluteString, "http://cashcats.biz/mobile_login")
    }

    func testSavingToTokenStoreWhenAuthTokenIsPresent() {
        controller.webview.load(URLRequest(url: controller.urlProvider.url(forPath: "/mobile_success")!))
        let cookie = HTTPCookie(properties: [.path:"\\",
                            .originURL: controller.urlProvider.url(forPath: "")!,
                            .name:"_pivots-two_session",
                            .value:"foo"])!
        HTTPCookieStorage.shared.setCookie(cookie)
        controller.webView(controller.webview, didFinish: nil)
        XCTAssertEqual(controller.tokenStore.token, cookie.value)

        XCTAssertEqual(viewControllerTransitioner.performSegueCallCount, 1)
        XCTAssertEqual(viewControllerTransitioner.performSegueArgsForCall(0).0, "PeopleViewController")
    }

    func testNotSavingTokenWhenAuthTokenIsNotPresent() {
        controller.webview.load(URLRequest(url: controller.urlProvider.url(forPath: "/mobile_success")!))
        controller.webView(controller.webview, didFinish: nil)
        XCTAssert(controller.tokenStore.token!.isEmpty)
    }
}
