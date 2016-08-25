struct Challenge {
    let choices: [Person]
    let target: Int

    static func ==(lhs: Challenge, rhs: Challenge) -> Bool {
        return lhs.choices == rhs.choices && lhs.target == rhs.target
    }
}
