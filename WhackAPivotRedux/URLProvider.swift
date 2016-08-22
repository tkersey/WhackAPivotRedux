import Foundation

struct URLProvider: URLProviderType {
    let baseURL: String

    func url(forPath path: String) -> URL? {
        return URL(string: "\(baseURL)\(path)")
    }

    func peopleURL() -> URL? {
        return url(forPath: "/api/users.json")
    }
}
