import Foundation
@testable import WhackAPivotRedux

class FakeNetwork: NetworkType, Equatable {
    private(set) var requestCallCount: Int = 0
    private var requestArgs: Array<(URLRequest, ((Data)) -> Void, (Error) -> Void)> = []
    func requestArgsForCall(_ callIndex: Int) -> (URLRequest, (Data) -> Void, (Error) -> Void) {
        return self.requestArgs[callIndex]
    }
    func request(with request: URLRequest, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        self.requestCallCount += 1
        self.requestArgs.append((request, success, failure))
    }

    static func ==(lhs: FakeNetwork, rhs: FakeNetwork) -> Bool {
        return lhs == rhs
    }
}
