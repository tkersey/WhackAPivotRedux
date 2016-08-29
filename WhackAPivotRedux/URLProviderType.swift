import Foundation

protocol URLProviderType {
    func url(forPath path: String) -> URL?
    func peopleURL() -> URL?
}
