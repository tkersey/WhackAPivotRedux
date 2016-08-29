struct AnyRandomizer<ErasedDataType: Hashable>: RandomizerType {
    private let _randomSubset: (Int, [ErasedDataType], Set<ErasedDataType>) -> Challenge

    init<Injected: RandomizerType>(_ randomizer: Injected) where Injected.DataType == ErasedDataType {
        _randomSubset = randomizer.randomSubset
    }

    func randomSubset(ofSize: Int, from: [ErasedDataType], avoiding toAvoid: Set<ErasedDataType>) -> Challenge {
        return _randomSubset(ofSize, from, toAvoid)
    }
}
