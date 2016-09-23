@testable import WhackAPivotRedux

struct FakeDispatch: DispatchType {
    func mainAsync(execute: @escaping () -> Void) {
        execute()
    }
}
