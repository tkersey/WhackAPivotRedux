import UIKit

struct PersonPresenter: PersonPresenterType {
    func display(_ person: Person, button: UIButton) {
        button.setBackgroundImage(person.image, for: .normal)
    }
}
