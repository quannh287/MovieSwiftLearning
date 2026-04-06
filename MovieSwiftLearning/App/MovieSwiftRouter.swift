//
//  MovieSwiftRouter.swift
//  MovieSwiftLearning
//
//  Created by Nguyễn Hồng Quân on 6/4/26.
//

import SwiftUI
import Combine

// AppRoute: các màn hình cấp cao nhất (top-level flow)
// So sánh với RN: Stack.Navigator root screens
// So sánh với Flutter: GoRouter top-level routes
enum AppRoute {
    case onboarding
    case auth
    case main
}

// AuthRoute: các màn hình trong Auth flow
// Dùng với NavigationStack để push/pop
enum AuthRoute: Hashable {
    case signIn
    case signUp
    case success
}

// MainTab: các tab trong Bottom Navigation
// So sánh với RN: Tab.Navigator screens
// So sánh với Flutter: BottomNavigationBar items
enum MainTab {
    case movies
    case tickets
    case profile
}

// MainRoute: navigation trong Main flow (NavigationStack per tab)
// So sánh với RN: Stack.Navigator bên trong Tab.Navigator
enum MainRoute: Hashable {
    case movieDetail(movie: Movie)
}

// MovieSwiftRouter: global app state router
// Tương đương RN: NavigationContainer + useNavigation
// Tương đương Flutter: GoRouter / Navigator 2.0
final class MovieSwiftRouter: ObservableObject {
    // isLoggedIn: flag đánh dấu user đã đăng nhập chưa, persist qua UserDefaults
    // So sánh với RN: AsyncStorage.getItem('isLoggedIn')
    // So sánh với Flutter: SharedPreferences.getBool('isLoggedIn')
    @Published var isLoggedIn: Bool {
        didSet { UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn") }
    }

    // currentRoute quyết định màn hình nào đang hiện ở root
    @Published var currentRoute: AppRoute = .onboarding

    // authPath: NavigationStack path cho Auth flow
    @Published var authPath: [AuthRoute] = []

    // mainPath: NavigationStack path cho Main flow (movie detail, v.v.)
    @Published var mainPath: [MainRoute] = []

    // selectedTab: tab đang active trong MainView
    @Published var selectedTab: MainTab = .movies

    init() {
        // Đọc trạng thái login từ UserDefaults khi khởi động app
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }

    // MARK: - Top-level navigation

    func switchTo(route: AppRoute) {
        // withAnimation(.easeInOut) để transition mượt giữa các top-level screens
        withAnimation(.easeInOut(duration: 0.3)) {
            currentRoute = route
        }
    }

    // Dùng khi rời onboarding (Skip hoặc Next cuối): check login để quyết định route
    func leaveOnboarding() {
        switchTo(route: isLoggedIn ? .main : .auth)
    }

    // MARK: - Auth flow

    func navigateToSignUp() {
        authPath.append(.signUp)
    }

    func navigateToAuthSuccess() {
        authPath.append(.success)
    }

    func authCompleted() {
        // Xong auth → đánh dấu đã login, chuyển sang main, reset auth path
        isLoggedIn = true
        authPath = []
        switchTo(route: .main)
    }

    func logout() {
        // Đăng xuất: clear flag, quay về onboarding
        isLoggedIn = false
        mainPath = []
        selectedTab = .movies
        switchTo(route: .onboarding)
    }

    // MARK: - Main flow

    func navigateToMovieDetail(movie: Movie) {
        mainPath.append(.movieDetail(movie: movie))
    }

    func popMain() {
        if !mainPath.isEmpty {
            mainPath.removeLast()
        }
    }
}
