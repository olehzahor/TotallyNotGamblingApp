import UIKit
import OneSignal
import FBSDKCoreKit
import Firebase
import YandexMobileMetrica

class AppDelegate: UIResponder, UIApplicationDelegate {
    fileprivate func setupOneSignal(_ launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId(Constants.onesignalAppId)

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
