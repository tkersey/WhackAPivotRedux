import UIKit
import ReSwift

class GameViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!

    var peopleService: PeopleServiceType = PeopleService(filter: { $0.locationName == "Los Angeles" })
}

// MARK: - State
extension GameViewController: StoreSubscriber {
    func newState(state: AppState) {
        let challengeState = state.challengeState

        if !challengeState.hasPeople {
            store.dispatch(People(service: peopleService).fetch)
        }

        if state.readyForChallenge {
            store.dispatch(CreateChallenge(per: 6))
        }

        if let challenge = challengeState.challenge {
            if let correctSelection = challengeState.correctSelection {
                resultLabel.isHidden = correctSelection
            }

            for (index, person) in challenge.choices.enumerated() {
                buttons[index].setBackgroundImage(person.image, for: .normal)
            }

            nameLabel.text = challenge.choices[challenge.target].name
        }
    }
}

// MARK: - Display
extension GameViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)

        resultLabel.isHidden = true
        resultLabel.text = "Incorrect!"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - Actions
extension GameViewController {
    @IBAction func buttonWasPressed(_ sender: UIButton) {
        if let buttonIndex = buttons.index(of: sender) {
            store.dispatch(UpdateChallenge(selected: buttonIndex))
        }
    }
}
