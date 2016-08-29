import UIKit

class PeopleViewController: UIViewController {
    var viewControllerTransitioner: ViewControllerTransitioner!
    var peopleService: PeopleServiceType = PeopleService()
    var peopleStore: PeopleStoreType = PeopleStore()
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
                self.viewControllerTransitioner.dismiss(animated: true, completion: nil)
            }, filter: { $0.locationName == "Los Angeles" })
    }
}
