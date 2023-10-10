//
//  PostsViewModel.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 9/25/23.
//

import Foundation

@MainActor
class PostsViewModel: ObservableObject {
    enum Filter {
        case all, favorites
    }
    
    @Published var posts: Loadable<[Post]> = .loading
    
    private let postsRepository: PostsRepositoryProtocol
    private let filter: Filter
    
    init(filter: Filter = .all, postsRepository: PostsRepositoryProtocol = PostsRepository()) {
        self.filter = filter
        self.postsRepository = postsRepository
    }
    
    func makePostRowViewModel(for post: Post) -> PostRowViewModel {
        return PostRowViewModel(
            post: post,
            deleteAction: {
                [weak self] in
                    try await self?.postsRepository.delete(post)
                self?.posts.value?.removeAll { $0.id == post.id }
            },
            favoriteAction: { [weak self] in
                let newValue = !post.isFavorite
                
                //Update the document in Firestore
                try await newValue ? self?.postsRepository.favorite(post) : self?.postsRepository.unfavorite(post)
                
                //Update the PostsList
                guard let index = self?.posts.value?.firstIndex(of: post) else { return }
                self?.posts.value?[index].isFavorite = newValue
            }
        )
    }
    
    func makeCreateAction() -> NewPostForm.CreateAction {
        return { [weak self] post in
            try await self?.postsRepository.create(post)
            self?.posts.value?.insert(post, at: 0)
        }
    }
    
    func fetchPosts() {
        Task {
            do {
                posts = .loaded(try await postsRepository.fetchPosts(matching: filter))
            }
            catch {
                print("[PostsViewModel] Cannot fetch posts: \(error)")
                posts = .error(error)
            }
        }
    }
}

extension PostsRepositoryProtocol {
    func fetchPosts(matching filter: PostsViewModel.Filter) async throws -> [Post] {
        switch filter {
        case .all:
            return try await fetchAllPosts()
        case .favorites:
            return try await fetchFavoritePosts()
        }
    }
}
