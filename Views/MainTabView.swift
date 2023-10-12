//
//  MainTabView.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 10/9/23.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var factory: ViewModelFactory
    
    var body: some View {
        TabView {
            PostsList(viewModel: factory.makePostsViewModel())
                .tabItem {
                    Label("Posts", systemImage: "list.dash")
                }
            PostsList(viewModel: factory.makePostsViewModel(filter: .favorites))
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(ViewModelFactory.preview)
}
