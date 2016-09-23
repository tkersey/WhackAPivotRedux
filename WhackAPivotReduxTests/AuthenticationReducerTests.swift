import XCTest
@testable import WhackAPivotRedux

class AuthenticationReducerTests: XCTestCase {
    var wrongCookie: HTTPCookie!
    var rightCookie: HTTPCookie!

    override func setUp() {
        super.setUp()

        wrongCookie = HTTPCookie(properties: [HTTPCookiePropertyKey.domain: ".google.com", HTTPCookiePropertyKey.path: "/",
                                              HTTPCookiePropertyKey.name: "NoCookie", HTTPCookiePropertyKey.value: "NOT_A_COOKIE"])!
        rightCookie = HTTPCookie(properties: [HTTPCookiePropertyKey.domain: ".google.com", HTTPCookiePropertyKey.path: "/",
                                              HTTPCookiePropertyKey.name: "_pivots-two_session", HTTPCookiePropertyKey.value: "GotYourCookie"])!
    }

    func testInitialAuthenticationState() {
        let state = authenticationReducer(state: FakeAuthenticationState(), action: ReSwiftInit())
        XCTAssertNil(state.sessionToken)
    }

    func testSettingSessionToken() {
        let state = authenticationReducer(state: FakeAuthenticationState(), action: SetSessionToken(cookies: [wrongCookie, rightCookie]))
        XCTAssertEqual("GotYourCookie", state.sessionToken)
    }

    func testNotSettingSessionTokenWhenCookieIsNotPresent() {
        let state = authenticationReducer(state: FakeAuthenticationState(), action: SetSessionToken(cookies: [wrongCookie]))
        XCTAssertNil(state.sessionToken)
    }
}
