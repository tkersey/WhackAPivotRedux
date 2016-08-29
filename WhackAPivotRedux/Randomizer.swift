import Foundation
import GameplayKit

struct Randomizer: RandomizerType {
    typealias DataType = Person

    func randomSubset(ofSize: Int, from: [DataType], avoiding toAvoid: Set<DataType>) -> Challenge {
        let all = Set(from)
        let potential = all.subtracting(toAvoid)
        let target = Array(potential)[Int(arc4random_uniform(UInt32(potential.count)))]
        let remaining = (Array(all.subtracting([target])) as NSArray).shuffled() as! Array<DataType>
        let choices = (Array([target] + remaining[0..<(ofSize-1)]) as NSArray).shuffled() as! Array<DataType>

        return Challenge(choices: choices, target: choices.index(of: target)!)
    }
}
