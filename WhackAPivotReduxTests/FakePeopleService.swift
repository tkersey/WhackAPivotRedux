import Foundation
@testable import WhackAPivotRedux

class FakePeopleService: PeopleServiceType, Equatable {
    init() {
        self._filter = { _ in false }
        self.set_filterArgs = []
    }

    var url: URL?
    var token: String?
    var dispatch: DispatchType = FakeDispatch()

    private var _filter: (Person) -> Bool
    private var set_filterArgs: [(Person) -> Bool]

    var filter: (Person) -> Bool {
        get {
            return _filter
        }

        set {
            _filter = newValue
            set_filterArgs.append(newValue)
        }
    }
    private(set) var getPeopleCallCount: Int = 0
    private var getPeopleArgs: Array<(([Person]) -> Void, (Error) -> Void, ((Person) -> Bool)?)> = []
    var getPeopleSuccessStub: [Person]?
    func getPeopleArgsForCall(_ callIndex: Int) -> (([Person]) -> Void, (Error) -> Void, ((Person) -> Bool)?) {
        return self.getPeopleArgs[callIndex]
    }
    func getPeople(success: @escaping ([Person]) -> Void, failure: @escaping (Error) -> Void, filter: @escaping (Person) -> Bool) {
        self.getPeopleCallCount += 1
        self.getPeopleArgs.append((success, failure, filter))
        if let people = getPeopleSuccessStub {
            success(people)
        }
    }

    static func ==(lhs: FakePeopleService, rhs: FakePeopleService) -> Bool {
        return lhs == rhs
    }
}
