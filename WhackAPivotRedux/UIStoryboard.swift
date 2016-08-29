import UIKit

extension UIStoryboard {
    static func loadViewController<T>(viewControllerIdentifier identifier: ViewController) -> T {
        let storyboard = UIStoryboard(name: identifier.rawValue.storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier.rawValue.identifier) as! T
    }
}
