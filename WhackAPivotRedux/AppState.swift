import Foundation

struct AppState: StateType {
    var authenticationState: AuthenticationStateType
    var challengeState: ChallengeStateType

    var readyForChallenge: Bool {
        return challengeState.challenge == nil && challengeState.hasPeople && authenticationState.loggedIn
    }

    // MARK: - URLS
    let loginSuccessURL = URL(string: "https://pivots.pivotallabs.com/mobile_success")
    let loginURL = URL(string: "https://pivots.pivotallabs.com/mobile_login")
    let peopleURL = URL(string: "https://pivots.pivotallabs.com/api/users.json")
}
