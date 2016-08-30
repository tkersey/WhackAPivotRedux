protocol RandomizerType {
    associatedtype DataType: Hashable
    func randomSubset(ofSize: Int, from: [DataType], avoiding toAvoid: Set<DataType>) -> Challenge<DataType>
}
