//
//  TotallyNotGamblingAppApp.swift
//  TotallyNotGamblingApp
//
//  Created by jjurlits on 3/23/21.
//

import SwiftUI

@main
struct TotallyNotGamblingAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
