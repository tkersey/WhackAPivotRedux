protocol ChallengeServiceType {
    associatedtype Element: Hashable
    func newGame(people: [Element], perChallenge: Int)
    func getChallenge() -> Challenge<Element>?
}
