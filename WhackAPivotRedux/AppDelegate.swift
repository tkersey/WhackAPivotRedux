import UIKit

var store: Store<AppState>!

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        store = Store<AppState>(reducer: AppReducer(), state: nil)
        return true
    }
}
