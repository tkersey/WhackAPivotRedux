import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!

    var peopleStore: PeopleStoreType = PeopleStore()
    var challengeService: ChallengeServiceType = ChallengeService(randomizer: Randomizer())
    var personPresenter: PersonPresenterType = PersonPresenter()

    fileprivate var challenge: Challenge?
}

// MARK: - Display
extension GameViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        resultLabel.isHidden = true

        if let people = peopleStore.people {
            challengeService.newGame(people: people, perChallenge: 6)
            setupChallenge()
        }
    }
}

// MARK: - Actions
extension GameViewController {
    @IBAction func buttonWasPressed(_ sender: UIButton) {
        if let buttonIndex = buttons.index(of: sender), buttonIndex == challenge?.target {
            resultLabel.isHidden = true
            setupChallenge()
        } else {
            resultLabel.isHidden = false
            resultLabel.text = "Incorrect!"
        }
    }
}

// MARK: - Private
fileprivate extension GameViewController {
    func setupChallenge() {
        challenge = challengeService.getChallenge()

        if let challenge = challenge {
            for (index, person) in challenge.choices.enumerated() {
                personPresenter.display(person, button: buttons[index])
            }

            nameLabel.text = challenge.choices[challenge.target].name
        }
    }
}
