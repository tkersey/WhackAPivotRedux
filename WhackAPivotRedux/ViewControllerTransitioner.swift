import UIKit

protocol ViewControllerTransitioner {
    func performSegue(withIdentifier: String, sender: Any?)
}

extension UIViewController: ViewControllerTransitioner {}
