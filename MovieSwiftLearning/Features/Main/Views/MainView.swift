//
//  MainView.swift
//  MovieSwiftLearning
//
//  Created by Nguyễn Hồng Quân on 6/4/26.
//

import SwiftUI

// MainView = Bottom Navigation container
// So sánh với RN: Tab.Navigator
// So sánh với Flutter: Scaffold với BottomNavigationBar
struct MainView: View {
    @EnvironmentObject private var router: MovieSwiftRouter

    var body: some View {
        // TabView binding vào router.selectedTab để có thể điều khiển tab từ bên ngoài
        TabView(selection: $router.selectedTab) {
            // Tab 1: Movies — có NavigationStack riêng để push MovieDetail
            MoviesTabView()
                .tabItem {
                    Label("Movies", systemImage: "film.fill")
                }
                .tag(MainTab.movies)

            // Tab 2: Tickets
            TicketsTabView()
                .tabItem {
                    Label("Tickets", systemImage: "ticket.fill")
                }
                .tag(MainTab.tickets)

            // Tab 3: Profile
            ProfileTabView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
                .tag(MainTab.profile)
        }
    }
}

// MARK: - Movies Tab

// MoviesTabView bọc NavigationStack để xử lý push MovieDetail
// So sánh với RN: Stack.Navigator bên trong Tab.Navigator
struct MoviesTabView: View {
    @EnvironmentObject private var router: MovieSwiftRouter

    var body: some View {
        // NavigationStack(path:) binding vào router.mainPath
        // Khi router.navigateToMovieDetail() được gọi, stack tự push MovieDetailView
        NavigationStack(path: $router.mainPath) {
            MovieView()
                .navigationDestination(for: MainRoute.self) { route in
                    switch route {
                    case .movieDetail(let movie):
                        MovieDetailView(movie: movie)
                    }
                }
        }
    }
}

// MARK: - Tickets Tab

struct TicketsTabView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "ticket.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.secondary)

                Text("Vé của bạn")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Tính năng đang phát triển")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Tickets")
        }
    }
}

// MARK: - Profile Tab

struct ProfileTabView: View {
    @EnvironmentObject private var router: MovieSwiftRouter

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.secondary)

                Text("Tài khoản")
                    .font(.title2)
                    .fontWeight(.semibold)

                // Đăng xuất → quay về Onboarding
                Button {
                    router.logout()
                } label: {
                    Text("Đăng xuất")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    MainView()
        .environmentObject(MovieSwiftRouter())
}
