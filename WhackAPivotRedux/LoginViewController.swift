import UIKit
import WebKit

class LoginViewController: UIViewController {
    var webview: WKWebView! = WKWebView()

    var viewControllerTransitioner: ViewControllerTransitioner!
    var peopleStore: PeopleStoreType = PeopleStore()
    var tokenStore: TokenStoreType = TokenStore()
    var urlProvider: URLProviderType = URLProvider(baseURL: "https://pivots.pivotallabs.com")
}

// MARK: - Display
extension LoginViewController {
    override func loadView() {
        super.loadView()

        viewControllerTransitioner = self

        webview.navigationDelegate = self
        webview.frame = view.frame
        view.addSubview(webview)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let people = peopleStore.people, people.count > 0 {
            viewControllerTransitioner.performSegue(withIdentifier: "segueToGame", sender: self)
        }

        if let token = tokenStore.token, !token.isEmpty {
            viewControllerTransitioner.performSegue(withIdentifier: "PeopleViewController", sender: self)
        } else if let url = urlProvider.url(forPath: "/mobile_login") {
            webview.load(URLRequest(url: url))
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - WKWebView delegate
extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.url == urlProvider.url(forPath: "/mobile_success"), let cookies = HTTPCookieStorage.shared.cookies {
            for case let cookie in cookies where cookie.name == "_pivots-two_session" {
                tokenStore.token = cookie.value
                viewControllerTransitioner.performSegue(withIdentifier: "PeopleViewController", sender: self)
            }
        }
    }
}
