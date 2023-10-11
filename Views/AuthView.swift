//
//  AuthView.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 10/10/23.
//

import SwiftUI

struct AuthView: View {
    @StateObject var viewModel = AuthViewModel()
    
    var body: some View {
        if viewModel.isAuthenticated {
            MainTabView()
        }
        else {
            Form {
                TextField("Email", text: $viewModel.email)
                SecureField("Password", text: $viewModel.password)
                Button("Sign Up") {
                    viewModel.signIn()
                }
            }
        }
    }
}

#Preview {
    AuthView()
}
