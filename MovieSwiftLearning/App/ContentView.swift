//
//  ContentView.swift
//  MovieSwiftLearning
//
//  Created by Nguyễn Hồng Quân on 1/4/26.
//

import SwiftUI

// ContentView = RootView, quyết định hiển thị flow nào dựa trên router.currentRoute
// So sánh với RN: switch trong NavigationContainer
// So sánh với Flutter: MaterialApp.router với redirect logic
struct ContentView: View {
    @EnvironmentObject private var router: MovieSwiftRouter

    var body: some View {
        // Group + switch để swap toàn bộ root view khi route thay đổi
        Group {
            switch router.currentRoute {
            case .onboarding:
                OnboardingView()
            case .auth:
                AuthView()
            case .main:
                MainView()
            }
        }
        // transition mượt khi switch route (kết hợp với withAnimation trong router)
        .transition(.opacity)
    }
}

#Preview {
    ContentView()
        .environmentObject(MovieSwiftRouter())
}
