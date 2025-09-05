

import UIKit

extension String {
    func upperCasedFirstLetter() -> String {
        guard let firstCharacter = first else {
            return self
        }
        return String(firstCharacter).uppercased() + dropFirst()
    }
}


extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}
