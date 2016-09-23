@testable import WhackAPivotRedux

class FakeAppReducer: Reducer {
    private(set) var handleActionCallCount = 0
    var handleActionStub: ((Action, AppState?) -> AppState)?
    private var handleActionArgs: Array<(Action, AppState?)> = []
    func handleActionReturns(stubbedValues: AppState) {
        self.handleActionStub = { _,_ in return stubbedValues }
    }
    func handlActionArgsForCall(_ callIndex: Int) -> (Action, AppState?) {
        return self.handleActionArgs[callIndex]
    }
    func handleAction(action: Action, state: AppState?) -> AppState {
        handleActionCallCount += 1
        handleActionArgs.append((action, state))
        return self.handleActionStub!(action, state)
    }
}
