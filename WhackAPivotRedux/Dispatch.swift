import Foundation

struct Dispatch: DispatchType {
    func mainAsync(execute: @escaping () -> Void) {
        DispatchQueue.main.async(execute: execute)
    }
}
