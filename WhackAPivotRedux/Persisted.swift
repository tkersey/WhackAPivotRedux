import Foundation

struct Persisted: PersistedType {
    func load(key: PersistedKey) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }

    func save(string: String, key: PersistedKey) {
        UserDefaults.standard.set(string, forKey: key.rawValue)
    }
}

enum PersistedKey: String {
    case sessionToken
}
