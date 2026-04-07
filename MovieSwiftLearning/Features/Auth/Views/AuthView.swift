//
//  AuthView.swift
//  MovieSwiftLearning
//
//  Created by Nguyễn Hồng Quân on 6/4/26.
//

import SwiftUI

// AuthView = container cho Auth flow
// Dùng NavigationStack với path binding để push/pop SignIn → SignUp → Success
// So sánh với RN: Stack.Navigator trong Auth group
// So sánh với Flutter: Navigator với MaterialPageRoute
struct AuthView: View {
    @EnvironmentObject private var router: MovieSwiftRouter

    var body: some View {
        // NavigationStack(path:) binding vào router.authPath
        // Mọi push/pop đều đi qua router → dễ điều khiển từ bên ngoài
        NavigationStack(path: $router.authPath) {
            SignInView()
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .signIn:
                        SignInView()
                    case .signUp:
                        SignUpView()
                    case .success:
                        AuthSuccessView()
                    }
                }
        }
    }
}

// MARK: - Auth Success

// AuthSuccessView: màn hình xác nhận đăng nhập/đăng ký thành công
// Dark theme — icon checkmark lớn, title, subtitle, CTA vào app
// So sánh với RN: SuccessScreen trong Auth.Navigator
// So sánh với Flutter: SuccessPage với Scaffold(backgroundColor: Colors.black)
struct AuthSuccessView: View {
    @EnvironmentObject private var router: MovieSwiftRouter

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // Icon vòng tròn checkmark
                ZStack {
                    Circle()
                        .fill(Color(red: 0.9, green: 0.2, blue: 0.2).opacity(0.15))
                        .frame(width: 120, height: 120)

                    Circle()
                        .strokeBorder(Color(red: 0.9, green: 0.2, blue: 0.2).opacity(0.4), lineWidth: 1.5)
                        .frame(width: 120, height: 120)

                    Image(systemName: "checkmark")
                        .font(.system(size: 48, weight: .semibold))
                        .foregroundColor(Color(red: 0.9, green: 0.2, blue: 0.2))
                }
                .padding(.bottom, 40)

                // Title
                Text("You're In!")
                    .font(.inter(.title))
                    .foregroundColor(.white)
                    .padding(.bottom, 12)

                // Subtitle
                Text("Your account has been set up.\nLet's find something to watch.")
                    .font(.inter(.body))
                    .foregroundColor(Color.white.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()

                // CTA — authCompleted() → reset authPath + switchTo(.main)
                AppButton(title: "Start Exploring", horizontalPadding: 24) {
                    router.authCompleted()
                }
                .padding(.bottom, 48)
            }
        }
        // Ẩn nav bar & back button — user không quay lại sign in sau khi đăng nhập
        .navigationBarBackButtonHidden(true)
        #if canImport(UIKit)
        .navigationBarHidden(true)
        #endif
    }
}

#Preview {
    AuthView()
        .environmentObject(MovieSwiftRouter())
}
