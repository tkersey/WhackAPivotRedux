struct AuthenticationState: AuthenticationStateType {
    var cookieSessionName: String {
        return "_pivots-two_session"
    }

    var sessionToken: String? {
        get {
            return Persisted().load(key: .sessionToken)
        }

        set {
            if let newValue = newValue {
                Persisted().save(string: newValue, key: .sessionToken)
            }
        }
    }

    var loggedIn: Bool {
        return sessionToken != nil && !sessionToken!.isEmpty
    }
}
