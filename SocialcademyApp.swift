//
//  SocialcademyApp.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 9/25/23.
//

import SwiftUI
import Firebase

@main
struct SocialcademyApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
