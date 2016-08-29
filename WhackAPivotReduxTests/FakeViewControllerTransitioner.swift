@testable import WhackAPivotRedux

class FakeViewControllerTransitioner: ViewControllerTransitioner, Equatable {
    private(set) var dismissCallCount: Int = 0
    private var dismissArgs: Array<(Bool, (() -> Void)?)> = []
    func dismissArgsForCall(_ callIndex: Int) -> (Bool, (() -> Void)?) {
        return self.dismissArgs[callIndex]
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.dismissCallCount += 1
        self.dismissArgs.append((animated, completion))
    }

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
