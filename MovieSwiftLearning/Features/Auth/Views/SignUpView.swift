//
//  SignUpView.swift
//  MovieSwiftLearning
//
//  Created by Nguyễn Hồng Quân on 7/4/26.
//

import SwiftUI

// MARK: - Sign Up

// SignUpView: màn hình đăng ký tài khoản
// Dark theme giống SignInView — ZStack(black bg) + VStack(form + signInLink)
// So sánh với RN: RegisterScreen trong Auth.Navigator
// So sánh với Flutter: RegisterPage với Scaffold(backgroundColor: Colors.black)
struct SignUpView: View {
    @EnvironmentObject private var router: MovieSwiftRouter

    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()

            // Outer VStack: form trên + sign-in link pinned bottom
            VStack(spacing: 0) {
                signUpForm
                Spacer(minLength: 0)
                signInLink
            }
        }
        // Ẩn nav bar mặc định vì đã có back button tự custom trong form
        // navigationBarHidden wrap trong UIKit guard vì project có macOS in SUPPORTED_PLATFORMS
        #if canImport(UIKit)
        .navigationBarHidden(true)
        #endif
    }

    // MARK: - Sign Up form (top-aligned)

    private var signUpForm: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Khoảng cách từ top (tránh status bar)
            Spacer().frame(height: 64)

            // Back button
            Button {
                // NavigationStack tự pop khi dùng router.authPath.removeLast()
                // Tuy nhiên dùng dismiss environment sẽ portable hơn
            } label: {
                Image(systemName: "chevron.left")
                    .font(.inter(.headline))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color(white: 0.13))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.plain)

            Text("Sign Up")
                .font(.inter(.title))
                .foregroundColor(.white)

            // Fields
            VStack(spacing: 16) {
                AppTextField(placeholder: "Full Name", text: $name)

                AppTextField(placeholder: "E-mail", text: $email, keyboardType: .emailAddress)

                AppTextField(placeholder: "Password", text: $password, isSecure: true)

                AppTextField(placeholder: "Confirm Password", text: $confirmPassword, isSecure: true)
            }

            // Sign Up CTA — full width
            AppButton(title: "Sign Up", horizontalPadding: 0) {
                router.navigateToAuthSuccess()
            }

            // Divider "or"
            orDivider

            // Social login buttons
            socialButtons
        }
        .padding(.horizontal, 24)
    }

    // MARK: - "or" divider

    private var orDivider: some View {
        HStack(spacing: 12) {
            Rectangle()
                .fill(Color.white.opacity(0.5))
                .frame(height: 1)

            Text("or")
                .font(.inter(.caption))
                .foregroundColor(.white)

            Rectangle()
                .fill(Color.white.opacity(0.5))
                .frame(height: 1)
        }
    }

    // MARK: - Social login buttons

    private var socialButtons: some View {
        HStack(spacing: 16) {
            SocialSignUpButton(icon: "f.circle.fill", label: "Facebook") {}
            SocialSignUpButton(icon: "g.circle.fill", label: "Google") {}
            SocialSignUpButton(icon: "apple.logo", label: "Apple") {}
        }
    }

    // MARK: - Sign In link (pinned bottom)

    private var signInLink: some View {
        Button {
            // Pop back to SignIn
            if !router.authPath.isEmpty {
                router.authPath.removeLast()
            }
        } label: {
            // AttributedString để mix màu/weight trong cùng 1 Text
            // So sánh với RN: <Text><Text style={bold}>Sign In</Text></Text>
            // So sánh với Flutter: RichText với TextSpan
            Text(signInAttributedString)
                .font(.inter(.subheadline))
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.bottom, 36)
        .padding(.top, 8)
    }

    private var signInAttributedString: AttributedString {
        var base = AttributedString("Already have an account? ")
        base.foregroundColor = Color.white.opacity(0.6)

        var highlight = AttributedString("Sign In")
        highlight.foregroundColor = .white
        highlight.font = .inter(.subheadline).bold()

        return base + highlight
    }
}

// MARK: - SocialSignUpButton

// Reuse same style as SocialLoginButton in SignInView — separate private struct per file
private struct SocialSignUpButton: View {
    let icon: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color(white: 0.13))
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SignUpView()
            .environmentObject(MovieSwiftRouter())
    }
}
