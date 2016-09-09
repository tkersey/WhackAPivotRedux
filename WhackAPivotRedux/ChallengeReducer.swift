func challengeReducer(state: ChallengeStateType?, action: Action) -> ChallengeStateType {
    var state = state ?? ChallengeState()

    switch action {
    case _ as ReSwiftInit:
        state.people = People.load()
        state.previouslyTargeted = Set<Person>()
    case let action as SetPeople:
        state.people = action.people
    case let action as CreateChallenge:
        state.perChallenge = action.per
        let (challenge, previousPerson) = getChallenge(state: state)
        state.challenge = challenge
        if let previous = previousPerson {
            state.previouslyTargeted?.insert(previous)
        }
    case let action as UpdateChallenge:
        if let challenge = state.challenge {
            state.correctSelection = challenge.target == action.selected

            if challenge.target == action.selected {
                let (challenge, previousPerson) = getChallenge(state: state)
                state.challenge = challenge
                if let previous = previousPerson {
                    state.previouslyTargeted?.insert(previous)
                }
            }
        }
    default:
        break
    }

    return state
}

private var randomizer = AnyRandomizer(Randomizer<Person>())

private func getChallenge(state: ChallengeStateType) -> (Challenge<Person>?, Person?) {
    if let previous = state.previouslyTargeted, let people = state.people, let per = state.perChallenge {
        if previous.count == people.count { return (nil, nil) }
        let challenge = randomizer.randomSubset(ofSize: per, from: people, avoiding: previous)
        return (challenge, challenge.choices[challenge.target])
    }
    return (nil, nil)
}
