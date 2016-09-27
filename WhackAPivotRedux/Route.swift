import ReSwiftRouter

enum Route: RouteElementIdentifier {
    case game
    case login
}

extension Route {
    var identifier: RouteElementIdentifier {
        return self.rawValue
    }
}
