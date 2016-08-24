protocol RandomizerType {
    associatedtype Element: Hashable
    func randomSubset(ofSize: Int, from: [Element], avoiding toAvoid: Set<Element>) -> Challenge<Element>
}
