import UIKit
import ReSwiftRouter

class RootRoutable: Routable {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    private func toLoginViewController() -> Routable {
        window.rootViewController = UIStoryboard.loadViewController(viewControllerIdentifier: .login)
        return LoginRoutable(window.rootViewController!)
    }

    private func toGameViewController() -> Routable {
        window.rootViewController = UIStoryboard.loadViewController(viewControllerIdentifier: .game)
        return GameRoutable(window.rootViewController!)
    }

    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        switch to {
        case Route.game.identifier:
            completionHandler()
            return toGameViewController()
        case Route.login.identifier:
            completionHandler()
            return toLoginViewController()
        default:
            fatalError("Route not supported!")
        }
    }

    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        switch routeElementIdentifier {
        case Route.game.identifier:
            completionHandler()
            return toGameViewController()
        case Route.login.identifier:
            completionHandler()
            return toLoginViewController()
        default:
            fatalError("Route not supported!")
        }
    }

    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        completionHandler()
    }
}
