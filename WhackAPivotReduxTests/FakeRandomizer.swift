@testable import WhackAPivotRedux

class FakeRandomizer: RandomizerType {
    private(set) var randomSubsetCallCount: Int = 0
    var randomSubsetStub: ((Int, [Person], Set<Person>) -> Challenge<Person>)?
    private var randomSubsetArgs: Array<(Int, [Person], Set<Person>)> = []
    func randomSubsetReturns(stubbedValues: Challenge<Person>) {
        self.randomSubsetStub = { _, _, _ in
            return stubbedValues
        }
    }
    func randomSubsetArgsForCall(_ callIndex: Int) -> (Int, [Person], Set<Person>) {
        return self.randomSubsetArgs[callIndex]
    }
    func randomSubset(ofSize: Int, from: [Person], avoiding toAvoid: Set<Person>) -> Challenge<Person> {
        self.randomSubsetCallCount += 1
        self.randomSubsetArgs.append((ofSize, from, toAvoid))
        return self.randomSubsetStub!((ofSize, from, toAvoid))
    }
}
