import Foundation

protocol NetworkType {
    func request(with url: URL, success: @escaping ([String:AnyObject]?) -> Void, failure: @escaping (Error) -> Void)
}
