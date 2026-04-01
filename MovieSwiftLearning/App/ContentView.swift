//
//  ContentView.swift
//  MovieSwiftLearning
//
//  Created by Nguyễn Hồng Quân on 1/4/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MovieView()
                .tabItem {
                    Label("Movies", systemImage: "film.fill")
                }
            
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "square.stack.fill")
                }
            
            FanclubView()
                .tabItem {
                    Label("Fan Club", systemImage: "star.circle.fill")
                }
            
            MyListView()
                .tabItem {
                    Label("My Lists", systemImage: "text.badge.plus")
                }
        }
    }
}

#Preview {
    ContentView()
}
