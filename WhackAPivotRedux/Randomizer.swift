import Foundation
import GameplayKit

struct Randomizer<E>: RandomizerType where E: Hashable {
    typealias Element = E

    func randomSubset(ofSize: Int, from: [Randomizer.Element], avoiding toAvoid: Set<Randomizer.Element>) -> Challenge<Randomizer.Element> {
        let all = Set(from)
        let potential = all.subtracting(toAvoid)
        let target = Array(potential)[Int(arc4random_uniform(UInt32(potential.count)))]
        let remaining = (Array(all.subtracting([target])) as NSArray).shuffled() as! Array<E>
        let choices = (Array([target] + remaining[0..<(ofSize-1)]) as NSArray).shuffled() as! Array<E>

        return Challenge(choices: choices, target: choices.index(of: target)!)
    }
}
