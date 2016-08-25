import Foundation
import GameplayKit

struct Randomizer: RandomizerType {
    func randomSubset(ofSize: Int, from: [Person], avoiding toAvoid: Set<Person>) -> Challenge {
        let all = Set(from)
        let potential = all.subtracting(toAvoid)
        let target = Array(potential)[Int(arc4random_uniform(UInt32(potential.count)))]
        let remaining = (Array(all.subtracting([target])) as NSArray).shuffled() as! Array<Person>
        let choices = (Array([target] + remaining[0..<(ofSize-1)]) as NSArray).shuffled() as! Array<Person>

        return Challenge(choices: choices, target: choices.index(of: target)!)
    }
}
