import UIKit
@testable import WhackAPivotRedux

class FakePersonPresenter: PersonPresenterType {
    private(set) var displayCallCount: Int = 0
    private var displayArgs: Array<(Person, UIButton)> = []
    func displayArgsForCall(_ callIndex: Int) -> (Person, UIButton) {
       return self.displayArgs[callIndex]
    }
    func display(_ person: Person, button: UIButton) {
        self.displayCallCount += 1
        self.displayArgs.append((person, button))
    }
}
