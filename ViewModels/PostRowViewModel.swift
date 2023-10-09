//
//  PostRowViewModel.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 10/5/23.
//

import Foundation

@MainActor
class PostRowViewModel: ObservableObject {
    typealias Action = () async throws -> Void
    
    @Published var post: Post
    @Published var error: Error?
    
    private let deleteAction: Action
    private let favoriteAction: Action
    
    init(post: Post, deleteAction: @escaping Action, favoriteAction: @escaping Action) {
        self.post = post
        self.deleteAction = deleteAction
        self.favoriteAction = favoriteAction
    }
    
    func deletePost() {
        withErrorHandlingTask(perform: deleteAction)
    }
    
    func favoritePost() {
        withErrorHandlingTask(perform: favoriteAction)
    }
    
    func withErrorHandlingTask(perform action: @escaping Action) {
        Task {
            do {
                try await action()
            }
            catch {
                print("[PostRowViewModel] Error: \(error)")
                self.error = error
            }
        }
    }
}
