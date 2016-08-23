import Foundation
@testable import WhackAPivotRedux

class FakeURLProvider: URLProviderType {
    private(set) var urlCallCount: Int = 0
    var urlStub: ((String) -> (URL?))?
    private var urlArgs: Array<(String)> = []
    func urlReturns(stubbedValues: URL?) {
        self.urlStub = { (path: String) -> (URL?) in
            return stubbedValues
        }
    }
    func urlArgsForCall(callIndex: Int) -> (String) {
        return self.urlArgs[callIndex]
    }
    func url(forPath path: String) -> URL? {
        self.urlCallCount += 1
        self.urlArgs.append(path)
        return self.urlStub!(path)
    }

    private(set) var peopleURLCallCount: Int = 0
    var poepleURLStub: (() -> (URL?))?
    func peopleURLReturns(stubbedValues: URL?) {
        self.poepleURLStub = { return stubbedValues }
    }
    func peopleURL() -> URL? {
        self.peopleURLCallCount += 1
        return self.poepleURLStub!()
    }
}
