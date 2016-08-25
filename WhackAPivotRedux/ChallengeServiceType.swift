protocol ChallengeServiceType {
    func newGame(people: [Person], perChallenge: Int)
    func getChallenge() -> Challenge?
}
