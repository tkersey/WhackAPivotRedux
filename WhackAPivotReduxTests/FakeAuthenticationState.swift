@testable import WhackAPivotRedux

struct FakeAuthenticationState: AuthenticationStateType {
    var cookieSessionName: String {
        return "_pivots-two_session"
    }

    var sessionToken: String?

    var loggedIn: Bool {
        return sessionToken != nil && !sessionToken!.isEmpty
    }
}
