//
//  ProfileViewModel.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 11/14/23.
//

import Foundation

class ProfileViewModel: ObservableObject, ErrorHandler {
    @Published var name: String
    @Published var imageURL: URL? {
        didSet {
            imageURLDidChange(from: oldValue)
        }
    }
    @Published var error: Error?
    
    private let authService: AuthService
    
    init(user: User, authService: AuthService) {
        self.name = user.name
        self.imageURL = user.imageURL
        self.authService = authService
    }
    
    func signOut() {
        withErrorHandlingTask(perform: authService.signOut)
    }
    
    private func imageURLDidChange(from oldValue: URL?) {
        guard imageURL != oldValue else { return }
        withErrorHandlingTask { [self] in
            try await authService.updateProfileImage(to: imageURL)
        }
    }
}
