struct ChallengeService: ChallengeServiceType {
    let randomizer: AnyRandomizer<Person>

    private var previouslyTargeted: Set<Person>!
    private var perChallenge: Int!
    private var people: [Person]!

    init(randomizer: AnyRandomizer<Person>) {
        self.randomizer = randomizer
        self.previouslyTargeted = Set<Person>()
        self.people = []
        self.perChallenge = 0
    }

    mutating func newGame(people: [Person], perChallenge: Int) {
        self.people = people
        self.perChallenge = perChallenge
    }

    mutating func getChallenge() -> Challenge? {
        if previouslyTargeted.count == people.count { return nil }
        let challenge = randomizer.randomSubset(ofSize: perChallenge, from: people, avoiding: previouslyTargeted)
        previouslyTargeted.insert(challenge.choices[challenge.target])
        return challenge
    }
}
