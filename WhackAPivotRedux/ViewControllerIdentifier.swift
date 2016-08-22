struct ViewControllerIdentifier: Equatable {
    let storyboardName: String
    let identifier: String

    static func ==(lhs: ViewControllerIdentifier, rhs: ViewControllerIdentifier) -> Bool {
        return lhs.storyboardName == rhs.storyboardName && lhs.identifier == rhs.identifier
    }
}

extension ViewControllerIdentifier: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        let values = value.components(separatedBy: "::")
        self.init(storyboardName: values[0], identifier: values[1])
    }

    init(unicodeScalarLiteral value: String) {
        let values = value.components(separatedBy: "::")
        self.init(storyboardName: values[0], identifier: values[1])
    }

    init(extendedGraphemeClusterLiteral value: String) {
        let values = value.components(separatedBy: "::")
        self.init(storyboardName: values[0], identifier: values[1])
    }
}
