@testable import WhackAPivotRedux

class FakePeopleStore: PeopleStoreType, Equatable {
    init() {
        self._people = []
        self.set_peopleArgs = []
    }

    private var _people: [Person]?
    private var set_peopleArgs: [[Person]?]

    var people: [Person]? {
        get {
            return _people!
        }

        set {
            _people = newValue
            set_peopleArgs.append(newValue)
        }
    }

    static func ==(lhs: FakePeopleStore, rhs: FakePeopleStore) -> Bool {
        return lhs == rhs
    }
}
