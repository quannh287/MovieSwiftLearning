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

// MARK: - Sign In

struct SignInView: View {
    @EnvironmentObject private var router: MovieSwiftRouter

    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("Đăng nhập")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Mật khẩu", text: $password)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal, 32)

            // Sign In → success screen
            Button {
                router.navigateToAuthSuccess()
            } label: {
                Text("Đăng nhập")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 32)

            // Chuyển sang Sign Up
            Button {
                router.navigateToSignUp()
            } label: {
                Text("Chưa có tài khoản? **Đăng ký**")
                    .font(.subheadline)
            }

            Spacer()
        }
        .navigationTitle("Đăng nhập")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Sign Up

struct SignUpView: View {
    @EnvironmentObject private var router: MovieSwiftRouter

    @State private var name = ""
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("Tạo tài khoản")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                TextField("Họ tên", text: $name)
                    .textFieldStyle(.roundedBorder)

                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Mật khẩu", text: $password)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal, 32)

            // Sign Up → success screen
            Button {
                router.navigateToAuthSuccess()
            } label: {
                Text("Đăng ký")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 32)

            Spacer()
        }
        .navigationTitle("Đăng ký")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Auth Success

struct AuthSuccessView: View {
    @EnvironmentObject private var router: MovieSwiftRouter

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)

            Text("Đăng nhập thành công!")
                .font(.title2)
                .fontWeight(.bold)

            Spacer()

            // authCompleted() → reset authPath + switchTo(.main)
            Button {
                router.authCompleted()
            } label: {
                Text("Vào ứng dụng")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
        }
        .navigationTitle("Thành công")
        .navigationBarTitleDisplayMode(.inline)
        // Ẩn back button để user không quay lại sign in sau khi đăng nhập
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AuthView()
        .environmentObject(MovieSwiftRouter())
}
