protocol ChallengeStateType {
    var people: [Person]? { get set }

    var hasPeople: Bool { get }

    var previouslyTargeted: Set<Person>? { get set }
    var perChallenge: Int? { get set }
    var challenge: Challenge<Person>? { get set }
    var correctSelection: Bool? { get set }
}
