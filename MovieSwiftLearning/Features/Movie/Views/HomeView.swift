//
//  HomeView.swift
//  MovieSwiftLearning
//
//  Created by Nguyễn Hồng Quân on 1/4/26.
//

import SwiftUI

// MovieView = shell wrapper cho MoviesListView
// ContentView dùng MovieView trong TabView
struct MovieView: View {
    var body: some View {
        MoviesListView()
    }
}

#Preview {
    MovieView()
}
