//
//  ViewModelFactory.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 10/11/23.
//

import Foundation

@MainActor
class ViewModelFactory: ObservableObject {
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func makePostsViewModel(filter: PostsViewModel.Filter = .all) -> PostsViewModel {
        return PostsViewModel(filter: filter, postsRepository: PostsRepository(user: user))
    }
    
    // Initializes the `CommentsViewModel` and its dependency, `CommentsRepository`, using the given post and factory's `user` property
    func makeCommentsViewModel(for post: Post) -> CommentsViewModel {
        return CommentsViewModel(commentsRepository: CommentsRepository(user: user, post: post))
    }
}

#if DEBUG
extension ViewModelFactory {
    static let preview = ViewModelFactory(user: .testUser)
}
#endif
