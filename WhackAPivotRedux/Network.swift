import UIKit

struct Network: NetworkType {
    func request(with request: URLRequest, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: request) { data, response, error in
            if let data = data { success(data) }
            else if let error = error { failure(error) }
        }.resume()
    }
}
