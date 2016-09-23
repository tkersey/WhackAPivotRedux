import UIKit

class FakeWebView: UIWebView {
    private(set) var loadRequestCallCount = 0
    private var loadRequestArgs: Array<URLRequest> = []
    func loadRequestArgsForCall(_ callIndex: Int) -> URLRequest {
        return self.loadRequestArgs[callIndex]
    }

    override func loadRequest(_ request: URLRequest) {
        loadRequestCallCount += 1
        loadRequestArgs.append(request)
    }
}
