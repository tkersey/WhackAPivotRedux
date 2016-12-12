import ReSwift
import ReSwiftRouter

struct AppReducer: AppReducerType {
    func handleAction(action: Action, state: AppState?) -> AppState {
        return AppState(navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
                        authenticationState: authenticationReducer(state: state?.authenticationState, action: action),
                        challengeState: challengeReducer(state: state?.challengeState, action: action))
    }
}
