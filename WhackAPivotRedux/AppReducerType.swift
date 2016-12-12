import ReSwift

protocol AppReducerType {
    func handleAction(action: Action, state: AppState?) -> AppState
}
