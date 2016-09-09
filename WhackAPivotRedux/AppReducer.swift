struct AppReducer: Reducer {
    func handleAction(action: Action, state: AppState?) -> AppState {
        return AppState(authenticationState: authenticationReducer(state: state?.authenticationState, action: action),
                     challengeState: challengeReducer(state: state?.challengeState, action: action))
    }
}
