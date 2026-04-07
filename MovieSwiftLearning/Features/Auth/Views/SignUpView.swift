//
//  SignUpView.swift
//  MovieSwiftLearning
//
//  Created by Nguyễn Hồng Quân on 7/4/26.
//

import SwiftUI

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
                .font(.inter(.largeTitle))

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
                    .font(.inter(.headline))
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

#Preview {
    SignUpView()
}
