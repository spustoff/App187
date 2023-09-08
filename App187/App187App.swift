//
//  App187App.swift
//  App187
//
//  Created by Вячеслав on 9/7/23.
//

import SwiftUI
import FirebaseCore
import ApphudSDK
import Amplitude

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Apphud.start(apiKey: "app_QXt3kX9N3dQBHNwzLfS7rn5LFxXfod")
        Amplitude.instance().initializeApiKey("52d8f546f9cdfc5da2636b7e0ff66e96")

        FirebaseApp.configure()
        
        return true
    }
}

@main
struct App187App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        
        WindowGroup {
            
            NavigationView(content: {
                
                ContentView()
            })
        }
    }
}
