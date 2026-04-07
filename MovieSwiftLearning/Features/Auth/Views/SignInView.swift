//
//  SignInView.swift
//  MovieSwiftLearning
//
//  Created by Nguyễn Hồng Quân on 7/4/26.
//

import SwiftUI

// MARK: - Sign In

struct SignInView: View {
    @EnvironmentObject private var router: MovieSwiftRouter

    @State private var email = ""
    @State private var password = ""

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()

            // Outer VStack: form trên + sign-up link pinned bottom
            VStack(spacing: 0) {
                signInForm
                Spacer(minLength: 0)
                signUpLink
            }

            skipButton
        }
    }

    // MARK: - Skip button

    private var skipButton: some View {
        HStack {
            Spacer()
            Button("Skip") {
                router.leaveOnboarding()
            }
            .foregroundColor(.white)
            .font(.inter(.body))
            .padding(.trailing, 24)
            .padding(.top, 8)
        }
    }

    // MARK: - Sign In form (top-aligned)

    private var signInForm: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Khoảng cách từ top (tránh Skip button)
            Spacer().frame(height: 80)

            Text("Sign In")
                .font(.inter(.title))
                .foregroundColor(.white)

            // Fields
            VStack(spacing: 16) {
                AppTextField(placeholder: "E-mail", text: $email)

                AppTextField(placeholder: "Password", text: $password, isSecure: true)
            }

            // Forgot password — căn phải
            Button {
                // TODO: navigate to forgot password
            } label: {
                Text("Forgot password?")
                    .font(.inter(.subheadline))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)

            // Sign in CTA — full width
            AppButton(title: "Sign in", horizontalPadding: 0) {
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
                .foregroundColor(Color.white)

            Rectangle()
                .fill(Color.white.opacity(0.5))
                .frame(height: 1)
        }
    }

    // MARK: - Social login buttons

    private var socialButtons: some View {
        HStack(spacing: 16) {
            SocialLoginButton(icon: "f.circle.fill", label: "Facebook") {}
            SocialLoginButton(icon: "g.circle.fill", label: "Google") {}
            SocialLoginButton(icon: "apple.logo", label: "Apple") {}
        }
    }

    // MARK: - Sign Up link (pinned bottom)

    private var signUpLink: some View {
        Button {
            router.navigateToSignUp()
        } label: {
            // AttributedString để mix màu/weight trong cùng 1 Text (iOS 26+)
            // So sánh với RN: <Text><Text style={bold}>Sign Up</Text></Text>
            // So sánh với Flutter: RichText với TextSpan
            Text(signUpAttributedString)
                .font(.inter(.subheadline))
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.bottom, 36)
        .padding(.top, 8)
    }

    private var signUpAttributedString: AttributedString {
        var base = AttributedString("Don't you have an account? ")
        base.foregroundColor = Color.white.opacity(0.6)

        var highlight = AttributedString("Sign Up")
        highlight.foregroundColor = .white
        highlight.font = .inter(.subheadline).bold()

        return base + highlight
    }
}

// MARK: - SocialLoginButton

// Button hình chữ nhật bo góc, nền tối, icon trắng
// So sánh với RN: <TouchableOpacity style={styles.socialBtn}>
// So sánh với Flutter: OutlinedButton với custom style
private struct SocialLoginButton: View {
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
    SignInView()
        .environmentObject(MovieSwiftRouter())
}
