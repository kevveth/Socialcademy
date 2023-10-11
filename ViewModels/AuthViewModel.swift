//
//  AuthViewModel.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 10/10/23.
//

import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    
    private let authService = AuthService()
    
    @Published var email = ""
    @Published var password = ""
    
    init() {
        authService.$isAuthenticated.assign(to: &$isAuthenticated)
    }
    
    func signIn() {
        Task {
            do {
                try await authService.signIn(email: email, password: password)
            }
            catch {
                print("[AuthViewModel] \(error)")
            }
        }
    }
}
