import Foundation

protocol NetworkType {
    func request(with request: URLRequest, success: @escaping ([String:AnyObject]?) -> Void, failure: @escaping (Error) -> Void)
}
