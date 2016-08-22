import Foundation

struct TokenStore: TokenStoreType {
    enum Keys: String { case authToken }

    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.authToken.rawValue)
        }

        set {
           UserDefaults.standard.set(newValue, forKey: Keys.authToken.rawValue)
        }
    }
}
