import UIKit
import ReSwift
import ReSwiftRouter

var store: Store<AppState>!

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var router: Router<AppState>!
    var reducer: AppReducerType! = AppReducer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        store = Store<AppState>(reducer: reducer.handleAction, state: nil)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        if let window = window {
            router = Router(store: store, rootRoutable: RootRoutable(window: window)) { subscription in
                return subscription.select { $0.navigationState }
            }

            if !store.state.authenticationState.loggedIn {
                store.dispatch(SetRouteAction([Route.game.identifier, Route.login.identifier]))
            } else {
                store.dispatch(SetRouteAction([Route.game.identifier]))
            }
        }
        window?.makeKeyAndVisible()

        return true
    }
}
