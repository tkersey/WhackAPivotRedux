protocol RandomizerType {
    func randomSubset(ofSize: Int, from: [Person], avoiding toAvoid: Set<Person>) -> Challenge
}
