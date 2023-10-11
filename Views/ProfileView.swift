//
//  ProfileView.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 10/10/23.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    var body: some View {
        Button("Sign Out") {
            try! Auth.auth().signOut()
        }
    }
}

#Preview {
    ProfileView()
}
