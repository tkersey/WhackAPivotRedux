@testable import WhackAPivotRedux

class FakePeopleService: PeopleServiceType {
    private(set) var getPeopleCallCount: Int = 0
    private var getPeopleArgs: Array<(([Person]) -> Void, (Error) -> Void)> = []
    func getPeopleArgsForCall(callIndex: Int) -> (([Person]) -> Void, (Error) -> Void) {
        return self.getPeopleArgs[callIndex]
    }
    func getPeople(success: @escaping ([Person]) -> Void, failure: @escaping (Error) -> Void) {
        self.getPeopleCallCount += 1
        self.getPeopleArgs.append((success, failure))
    }
}
