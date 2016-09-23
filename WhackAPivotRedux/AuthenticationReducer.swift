func authenticationReducer(state: AuthenticationStateType?, action: Action) -> AuthenticationStateType {
    var state = state ?? AuthenticationState()

    switch action {
    case let action as SetSessionToken:
        for case let cookie in action.cookies where cookie.name == state.cookieSessionName {
            state.sessionToken = cookie.value
        }
    default:
        break
    }

    return state
}
