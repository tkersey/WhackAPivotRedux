import UIKit

protocol ViewControllerTransitioner {
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func performSegue(withIdentifier: String, sender: Any?)
}

extension UIViewController: ViewControllerTransitioner {}
