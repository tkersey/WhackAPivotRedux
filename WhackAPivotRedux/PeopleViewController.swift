import UIKit

class PeopleViewController: UIViewController {
    var viewControllerTransitioner: ViewControllerTransitioner!
    var peopleService: PeopleServiceType!
    var peopleStore: PeopleStoreType!
}

// MARK: - Display
extension PeopleViewController {
    override func loadView() {
        super.loadView()

        viewControllerTransitioner = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        peopleService.getPeople(success: { people in
            self.peopleStore.people = people
            self.viewControllerTransitioner.performSegue(withIdentifier: "segueToGame", sender: self)
            }, failure: { _ in
                self.viewControllerTransitioner.performSegue(withIdentifier: "segueToLogin", sender: self)
            }, filter: { $0.locationName == "Los Angeles" })
    }
}
