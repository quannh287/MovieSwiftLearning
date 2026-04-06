//
//  MovieSwiftLearningApp.swift
//  MovieSwiftLearning
//
//  Created by Nguyễn Hồng Quân on 1/4/26.
//

import SwiftUI

@main
struct MovieSwiftLearningApp: App {
    // StateObject: App sở hữu router, inject vào toàn bộ view tree qua environmentObject
    // So sánh với RN: <NavigationContainer> bọc toàn bộ app
    // So sánh với Flutter: MaterialApp(router: GoRouter(...))
    @StateObject private var router = MovieSwiftRouter()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
        }
    }
}
