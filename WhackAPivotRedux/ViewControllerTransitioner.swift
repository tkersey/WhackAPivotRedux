import UIKit

protocol ViewControllerTransitioner {
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

extension UIViewController: ViewControllerTransitioner {}
