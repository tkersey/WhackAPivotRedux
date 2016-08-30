protocol ChallengeServiceType {
    mutating func newGame(people: [Person], perChallenge: Int)
    mutating func getChallenge() -> Challenge<Person>?
}
