@testable import WhackAPivotRedux

class FakeTokenStore: TokenStoreType, Equatable {
    init() {
        self.set_tokenArgs = []
    }

    private var _token: String?
    private var set_tokenArgs: [String?]

    var token: String? {
        get {
            return _token
        }

        set {
            _token = newValue
            set_tokenArgs.append(newValue)
        }
    }

    static func ==(lhs: FakeTokenStore, rhs: FakeTokenStore) -> Bool {
        return lhs == rhs
    }
}
