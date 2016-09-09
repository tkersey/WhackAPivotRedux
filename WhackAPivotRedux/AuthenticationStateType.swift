protocol AuthenticationStateType {
    var cookieSessionName: String { get }
    var sessionToken: String? { get set }
    var loggedIn: Bool { get }
}
