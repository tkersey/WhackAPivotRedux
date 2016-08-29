struct Challenge<DataType: Hashable>: Equatable {
    let choices: [DataType]
    let target: Int

    static func ==(lhs: Challenge, rhs: Challenge) -> Bool {
        return lhs.choices == rhs.choices && lhs.target == rhs.target
    }
}
