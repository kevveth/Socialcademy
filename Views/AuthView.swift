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
            NavigationView {
                SignInForm(viewModel: viewModel.makeSignInViewModel()) {
                    NavigationLink("Create Account", destination: CreateAccountForm(viewModel: viewModel.makeCreateAccountViewModel()))
                }
            }
        }
    }
}

private extension AuthView {
    struct CreateAccountForm: View {
        @StateObject var viewModel: AuthViewModel.CreateAccountViewModel
        
        var body: some View {
            Form {
                TextField("Name", text: $viewModel.name)
                    .textContentType(.name)
                    .textInputAutocapitalization(.words)
                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.newPassword)
            } footer: {
                Button("Create Account", action: viewModel.submit)
            }
            .navigationTitle("Create Account")
            .onSubmit(viewModel.submit)
        }
    }
    
    struct SignInForm<Footer: View>: View{
        @StateObject var viewModel: AuthViewModel.SignInViewModel
        @ViewBuilder let footer: () -> Footer
        
        var body: some View {
            VStack {
                Form {
                    TextField("Email", text: $viewModel.email)
                        .textContentType(.emailAddress)
                    SecureField("Password", text: $viewModel.password)
                        .textContentType(.password)
                } footer: {
                    Button("Sign In", action: viewModel.submit)
                        .buttonStyle(.primary)
                    footer()
                }
                .onSubmit(viewModel.submit)
            }
        }
    }
}

struct Form<Content: View, Footer: View>: View {
    @ViewBuilder let content: () -> Content
    @ViewBuilder let footer: () -> Footer
    
    var body: some View {
        VStack {
            Text("Socialcademy")
                .font(.title.bold())
            
            content()
                .padding()
                .background(Color.secondary.opacity(0.15))
                .cornerRadius(10)
        }
        .navigationBarHidden(true)
        .padding()
    }
}

#Preview {
    AuthView()
}
