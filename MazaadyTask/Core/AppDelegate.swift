
import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        setAppearance()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = FormVCRouter.create()
        window?.makeKeyAndVisible()
        return true
    }

}


