//
//  PostRow.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 9/25/23.
//

import SwiftUI

struct PostRow: View {
    typealias DeleteAction = () async throws -> Void
    
    let post: Post
    let deleteAction: DeleteAction
    
    @State private var showConfirmationDialog = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(post.authorName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()
                Text(post.timeStamp.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
            }
            .foregroundColor(.gray)
            Text(post.title)
                .font(.title3)
                .fontWeight(.semibold)
            Text(post.content)
            HStack {
                Spacer()
                Button(role: .destructive, action: {
                    showConfirmationDialog = true
                }) {
                    Label("Delete", systemImage: "trash")
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.borderless)
                .confirmationDialog("Are you sure you want to delete this post?", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
                    Button("Delete", role: .destructive, action: deletePost)
                }
            }
        }
        .padding(.vertical)
    }
    
    private func deletePost() {
        Task {
            try await deleteAction()
        }
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PostRow(post: Post.testPost, deleteAction: {})
        }
    }
}
