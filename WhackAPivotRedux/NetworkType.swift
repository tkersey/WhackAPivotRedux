import Foundation

protocol NetworkType {
    func request(with request: URLRequest, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void)
}
