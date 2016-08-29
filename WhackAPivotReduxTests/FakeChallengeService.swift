@testable import WhackAPivotRedux

class FakeChallengeService: ChallengeServiceType {
    private(set) var newGameCallCount: Int = 0
    private var newGameArgs: Array<([Person], Int)> = []
    func newGameArgsForCall(_ callIndex: Int) -> ([Person], Int) {
       return self.newGameArgs[callIndex]
    }
    func newGame(people: [Person], perChallenge: Int) {
        self.newGameCallCount += 1
        self.newGameArgs.append((people, perChallenge))
    }

    private(set) var getChallengeCallCount: Int = 0
    var getChallengeStub: (() -> Challenge?)?
    func getChallengeReturns(stubbedValues: Challenge?) {
        self.getChallengeStub = { return stubbedValues }
    }
    func getChallenge() -> Challenge? {
        self.getChallengeCallCount += 1
        return self.getChallengeStub!()
    }

    static func ==(lhs: FakeChallengeService, rhs: FakeChallengeService) -> Bool {
        return lhs == rhs
    }
}
