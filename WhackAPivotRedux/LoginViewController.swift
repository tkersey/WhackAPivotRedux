import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    var viewControllerTransitioner: ViewControllerTransitioner!
    var loginSuccessURL: URL?
    var loginURL: URL?
}

// MARK: - State
extension LoginViewController: StoreSubscriber {
    func newState(state: AppState) {
        let authenticationState = state.authenticationState

        if authenticationState.loggedIn, let _ = viewIfLoaded {
            viewControllerTransitioner.dismiss(animated: true, completion: nil)
        }

        loginURL = state.loginURL
        loginSuccessURL = state.loginSuccessURL
    }
}

// MARK: - Display
extension LoginViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)

        viewControllerTransitioner = self

        webView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let url = loginURL {
            webView.loadRequest(URLRequest(url: url))
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - UIWebView delegate
extension LoginViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.request?.url == loginSuccessURL, let cookies = HTTPCookieStorage.shared.cookies {
            store.dispatch(SetSessionToken(cookies: cookies))
        }
    }
}
