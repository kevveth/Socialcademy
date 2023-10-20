//
//  CommentRow.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 10/19/23.
//

import SwiftUI

struct CommentRow: View {
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text(comment.author.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(comment.timestamp.formatted())
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            Text(comment.content)
                .font(.headline)
                .fontWeight(.regular)
        }
        .padding(5)
    }
}

#Preview {
    CommentRow(comment: Comment.testComment)
        .previewLayout(.sizeThatFits)
}
