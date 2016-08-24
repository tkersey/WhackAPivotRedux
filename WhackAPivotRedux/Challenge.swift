struct Challenge<E>: Equatable where E: Hashable {
    let choices: [E]
    let target: Int

    static func ==(lhs: Challenge, rhs: Challenge) -> Bool {
        return lhs.choices == rhs.choices && lhs.target == rhs.target
    }
}
