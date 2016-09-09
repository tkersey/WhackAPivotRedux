@testable import WhackAPivotRedux

struct FakeChallengeState: ChallengeStateType {
    var people: [Person]?
    var hasPeople: Bool {
        if let people = people {
            return !people.isEmpty
        }

        return false
    }

    var previouslyTargeted: Set<Person>?
    var perChallenge: Int?
    var challenge: Challenge<Person>?
    var correctSelection: Bool?
}
