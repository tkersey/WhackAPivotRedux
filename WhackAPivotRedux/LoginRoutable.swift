import UIKit
import ReSwiftRouter

class LoginRoutable: Routable {
    let viewController: UIViewController

    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    private func loginViewController() -> LoginViewController {
        return UIStoryboard.loadViewController(viewControllerIdentifier: .login)
    }

    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        if routeElementIdentifier == Route.login.identifier {
            viewController.present(loginViewController(), animated: animated, completion: completionHandler)
            return self
        } else {
            fatalError("Route not supported!")
        }
    }

    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        if routeElementIdentifier == Route.login.identifier {
            viewController.dismiss(animated: true, completion: completionHandler)
        }

        fatalError("Route not supported!")
    }
}
