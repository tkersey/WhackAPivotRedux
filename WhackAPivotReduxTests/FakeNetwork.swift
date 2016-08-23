import Foundation
@testable import WhackAPivotRedux

class FakeNetwork: NetworkType {
    private(set) var requestCallCount: Int = 0
    private var requestArgs: Array<(URL, (([String:AnyObject]?)) -> Void, (Error) -> Void)> = []
    func requestArgsForCall(callIndex: Int) -> (URL, ([String:AnyObject]?) -> Void, (Error) -> Void) {
        return self.requestArgs[callIndex]
    }
    func request(with url: URL, success: @escaping ([String:AnyObject]?) -> Void, failure: @escaping (Error) -> Void) {
        self.requestCallCount += 1
        self.requestArgs.append((url, success, failure))
    }
}
