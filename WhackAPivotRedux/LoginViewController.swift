import UIKit

class LoginViewController: UIViewController {
    var webView: UIWebView = UIWebView()

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

        webView.delegate = self
        webView.frame = view.frame
        view.addSubview(webView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let people = peopleStore.people, people.count > 0 {
            viewControllerTransitioner.performSegue(withIdentifier: "segueToGame", sender: self)
        }

        if let token = tokenStore.token, !token.isEmpty {
            viewControllerTransitioner.performSegue(withIdentifier: "PeopleViewController", sender: self)
        } else if let url = urlProvider.url(forPath: "/mobile_login") {
            webView.loadRequest(URLRequest(url: url))
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - UIWebView delegate
extension LoginViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.request?.url == urlProvider.url(forPath: "/mobile_success"), let cookies = HTTPCookieStorage.shared.cookies {
            for case let cookie in cookies where cookie.name == "_pivots-two_session" {
                tokenStore.token = cookie.value
                viewControllerTransitioner.performSegue(withIdentifier: "PeopleViewController", sender: self)
            }
        }
    }
}
