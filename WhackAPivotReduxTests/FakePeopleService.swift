@testable import WhackAPivotRedux

class FakePeopleService: PeopleServiceType, Equatable {
    private(set) var getPeopleCallCount: Int = 0
    private var getPeopleArgs: Array<(([Person]) -> Void, (Error) -> Void, ((Person) -> Bool)?)> = []
    func getPeopleArgsForCall(_ callIndex: Int) -> (([Person]) -> Void, (Error) -> Void, ((Person) -> Bool)?) {
        return self.getPeopleArgs[callIndex]
    }
    func getPeople(success: @escaping ([Person]) -> Void, failure: @escaping (Error) -> Void, filter: @escaping (Person) -> Bool) {
        self.getPeopleCallCount += 1
        self.getPeopleArgs.append((success, failure, filter))
    }

    static func ==(lhs: FakePeopleService, rhs: FakePeopleService) -> Bool {
        return lhs == rhs
    }
}
