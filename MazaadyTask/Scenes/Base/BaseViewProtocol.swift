
import UIKit

protocol BaseViewProtocol: AnyObject {
    func startLoading(message: String?)
    func setLoadingMessage(message: String)
    func stopLoading()
    func showSelfDismissingErrorAlert(_ message: String)
    func showSelfDismissingAlert(_ message: String)
    func showSelfDismissingAlert(_ message: String, after time: TimeInterval)
    func showConfirmationAlert(actionTitle: String?,
                               message: String,
                               okActionHandler: @escaping ((UIAlertAction) -> Void))
    func showConfirmationMsg(actionTitle: String?,
                             message: String,
                             okActionHandler: @escaping ((UIAlertAction) -> Void))
    func setLeftNavTitle(_ title: String)
    func pop()
    func popToRoot()
    func pop(after: Double)
    func setCenterNavTitle(_ title: String)
    func openLocation(coordinate: String)
    func presentAlertVC(title: String?,
                        message: String,
                        actions: [UIAlertAction])
}

extension BaseViewProtocol where Self: UIViewController {

    func startLoading(message: String? = nil) {
        startLoading(message: message)
    }

    func setLoadingMessage(message: String) {
        setLoadingMessage(message: message)
    }

    func stopLoading() {
        stopLoading()
    }

    func showSelfDismissingErrorAlert(_ message: String) {
        showErrorAlert(message: message)
    }

    func showSelfDismissingAlert(_ message: String) {
        showAlert(message: message)
    }

    func showSelfDismissingAlert(_ message: String, after time: TimeInterval) {
        showAlert(message: message, time: time)
    }

    func showConfirmationAlert(actionTitle: String?,
                               message: String,
                               okActionHandler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle ?? "Ok", style: .default, handler: okActionHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

    func showConfirmationMsg(actionTitle: String?,
                             message: String,
                             okActionHandler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle ?? "Ok", style: .default, handler: okActionHandler)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    func setLeftNavTitle(_ title: String) {
        let label = UILabel()
        label.text = title
        label.textColor = .black
        label.font = .poppins(.regular, size: 20)
        var topParent: UIViewController = self
        while topParent.parent != nil,
              String(describing: type(of: topParent.parent!.self))
                != String(describing: UINavigationController.self) {
            topParent = topParent.parent!
        }
        topParent.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        topParent.navigationItem.leftItemsSupplementBackButton = true
    }

    func setCenterNavTitle(_ title: String) {
        var topParent: UIViewController = self
        while topParent.parent != nil,
              String(describing: type(of: topParent.parent!.self))
                != String(describing: UINavigationController.self) {
            topParent = topParent.parent!
        }
        topParent.title = title
    }

    func pop() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
        dismiss(animated: true, completion: nil)
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }

    func pop(after: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func openLocation(coordinate: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            let application = UIApplication.shared
            let handlers = [
                ("Apple Maps", "http://maps.apple.com/?ll=\(coordinate)"),
                ("Google Maps", "comgooglemaps://?q=\(coordinate)"),
                ("Waze", "waze://?ll=\(coordinate)"),
                ("Citymapper", "citymapper://directions?endcoord=\(coordinate)")
            ]
                .compactMap { (name, address) in URL(string: address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!).map { (name, $0) } }
                .filter { (_, url) in application.canOpenURL(url) }

            guard handlers.count > 1 else {
                if let (_, url) = handlers.first {
                    application.open(url, options: [:])
                }
                return
            }
            let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
            handlers.forEach { (name, url) in
                alert.addAction(UIAlertAction(title: name, style: .default) { _ in
                    application.open(url, options: [:])
                })
            }
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func presentAlertVC(title: String?,
                        message: String,
                        actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions {
            alert.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }

}
