//
//  MainTabView.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 10/9/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            PostsList()
                .tabItem {
                    Label("Posts", systemImage: "list.dash")
                }
            PostsList(viewModel: PostsViewModel(filter: .favorites))
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}

#Preview {
    MainTabView()
}