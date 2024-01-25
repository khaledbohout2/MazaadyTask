
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
        let tabBarVc = ShadowTabBarVC()
        let homeVC = HomeVC()
        let discoverVC = DiscoveryVC()
        let messagesVC = MessagesVC()
        let profileVC = ProfileVC()
        tabBarVc.setViewControllers([homeVC.toNavigation(),
                                     discoverVC,
                                     messagesVC,
                                     profileVC],
                                    animated: false)
        window?.rootViewController = tabBarVc
        window?.makeKeyAndVisible()
        return true
    }

}

