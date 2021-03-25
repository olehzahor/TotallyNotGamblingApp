import UIKit
import OneSignal
import FBSDKCoreKit
import Firebase
import YandexMobileMetrica

class AppDelegate: UIResponder, UIApplicationDelegate {
    fileprivate func setupOneSignal(_ launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        // Remove this method to stop OneSignal Debugging
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        
        // OneSignal initialization
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId(Constants.onesignalAppId)
        
        // promptForPushNotifications will show the native iOS notification permission prompt.
        // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
    }
    
    fileprivate func setupYandex() {
        let configuration = YMMYandexMetricaConfiguration.init(apiKey: Constants.yandexApiKey)
        YMMYandexMetrica.activate(with: configuration!)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.setupOneSignal(launchOptions)
        self.setupYandex()
        FirebaseApp.configure()
        
        return true
    }
}
