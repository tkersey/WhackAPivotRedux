struct ChallengeState: ChallengeStateType {
    private var _people: [Person]?
    var people: [Person]? {
        get {
            return _people
        }

        set(newPeople) {
            _people = newPeople
            if let people = newPeople {
                People.save(people: people)
            }
        }
    }

    var hasPeople: Bool {
        if let people = _people {
            return !people.isEmpty
        }

        return false
    }

    // MARK: - Challenge
    var previouslyTargeted: Set<Person>?
    var perChallenge: Int?
    var challenge: Challenge<Person>?
    var correctSelection: Bool?
}
