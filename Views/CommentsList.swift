//
//  CommentsList.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 10/19/23.
//

import SwiftUI

struct CommentsList: View {
    @StateObject var viewModel: CommentsViewModel
    
    var body: some View {
        Group {
            switch viewModel.comments {
            case .loading:
                ProgressView()
                    .onAppear {
                        viewModel.fetchComments()
                    }
            case .error(let error):
                EmptyListView(
                    title: "Cannot load comments",
                    message: error.localizedDescription,
                    retryAction: {
                        viewModel.fetchComments()
                    }
                )
            case .empty:
                EmptyListView(title: "No Comments",
                              message: "Be the first to leave a comment.")
            case .loaded(let comments):
                List(comments) { comment in
                    
                }
                .animation(.default, value: comments)
            }
        }
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
struct CommentsList_Previews: PreviewProvider {
    static var previews: some View {
        ListPreview(state: .loaded([Comment.testComment]))
        ListPreview(state: .empty)
        ListPreview(state: .error)
        ListPreview(state: .loading)
    }
    
    private struct ListPreview: View {
        let state: Loadable<[Comment]>
        
        var body: some View {
            NavigationView {
                CommentsList(viewModel: CommentsViewModel(commentsRepository: CommentsRepositoryStub(state: state)))
            }
        }
    }
}
#endif
