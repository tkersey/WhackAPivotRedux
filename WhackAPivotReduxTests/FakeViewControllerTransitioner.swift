@testable import WhackAPivotRedux

class FakeViewControllerTransitioner: ViewControllerTransitioner, Equatable {
    private(set) var performSegueCallCount : Int = 0
    private var performSegueArgs : Array<(String, Any?)> = []
    func performSegueArgsForCall(_ callIndex: Int) -> (String, Any?) {
        return self.performSegueArgs[callIndex]
    }
    func performSegue(withIdentifier identifier: String, sender: Any?) {
        self.performSegueCallCount += 1
        self.performSegueArgs.append((identifier, sender))
    }

    static func ==(lhs: FakeViewControllerTransitioner, rhs: FakeViewControllerTransitioner) -> Bool {
        return lhs == rhs
    }
}
