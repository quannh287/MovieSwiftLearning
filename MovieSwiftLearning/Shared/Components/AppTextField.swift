//
//  AppTextField.swift
//  MovieSwiftLearning
//

import SwiftUI

// MARK: - AppTextField

// AppTextField: input field với 3 state: default, valid, error
// Hỗ trợ cả text thường và secure (password) với eye toggle
// So sánh với RN: <TextInput> + custom border style
// So sánh với Flutter: TextField với InputDecoration

enum AppTextFieldState {
    case idle       // chưa nhập / chưa validate
    case valid      // hợp lệ — viền trắng mờ + checkmark
    case error(String) // không hợp lệ — viền đỏ + error message
}

struct AppTextField: View {
    let placeholder: String
    @Binding var text: String
    var state: AppTextFieldState = .idle
    var isSecure: Bool = false

    @State private var isRevealed: Bool = false
    @FocusState private var isFocused: Bool

    // MARK: - Computed border color

    private var borderColor: Color {
        switch state {
            case .idle:          return isFocused ? Color.white.opacity(0.4) : Color.white.opacity(0.15)
            case .valid:         return Color.white.opacity(0.35)
            case .error:         return Color(red: 0.9, green: 0.2, blue: 0.2)
        }
    }

    private var errorMessage: String? {
        if case .error(let msg) = state { return msg }
        return nil
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 0) {
                // Input
                // prompt: Text với màu trắng mờ để placeholder hiển thị rõ trên nền tối
                // So sánh với RN: placeholderTextColor prop trên TextInput
                // So sánh với Flutter: hintStyle: TextStyle(color: ...) trong InputDecoration
                Group {
                    if isSecure && !isRevealed {
                        SecureField(
                            text: $text,
                            prompt: Text(placeholder).foregroundStyle(Color.white.opacity(0.4))
                        ) { EmptyView() }
                    } else {
                        TextField(
                            text: $text,
                            prompt: Text(placeholder).foregroundStyle(Color.white.opacity(0.4))
                        ) { EmptyView() }
                    }
                }
                .focused($isFocused)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .font(.inter(.body))
                .foregroundColor(.white)
                .padding(.leading, 16)
                .padding(.vertical, 16)

                // Trailing icon
                trailingIcon
                    .padding(.trailing, 14)
            }
            .background(Color(white: 0.11))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1.5)
            )
            .animation(.easeInOut(duration: 0.15), value: isFocused)

            // Error message
            if let msg = errorMessage {
                Text(msg)
                    .font(.inter(.caption))
                    .foregroundColor(Color(red: 0.9, green: 0.2, blue: 0.2))
                    .padding(.horizontal, 4)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: errorMessage)
    }

    // MARK: - Trailing icon

    @ViewBuilder
    private var trailingIcon: some View {
        if isSecure {
            // Eye toggle cho password field
            Button {
                isRevealed.toggle()
            } label: {
                Image(systemName: isRevealed ? "eye" : "eye.slash")
                    .foregroundColor(Color.white.opacity(0.4))
                    .frame(width: 24, height: 24)
            }
            .buttonStyle(.plain)
        } else {
            switch state {
            case .valid:
                // Checkmark đỏ cho valid text field
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color(red: 0.9, green: 0.2, blue: 0.2))
                    .frame(width: 24, height: 24)
                    .transition(.scale.combined(with: .opacity))
            default:
                // Placeholder để giữ layout ổn định
                Color.clear.frame(width: 24, height: 24)
            }
        }
    }
}

// MARK: - Preview

#Preview("States") {
    VStack(spacing: 16) {
        AppTextField(
            placeholder: "E-mail",
            text: .constant(""),
            state: .idle
        )

        AppTextField(
            placeholder: "E-mail",
            text: .constant("sarthakranjanhota@gmail.com"),
            state: .valid
        )

        AppTextField(
            placeholder: "E-mail",
            text: .constant("sarthakranjanhotagmail.com"),
            state: .error("Oops! It seems like you entered an invalid email address. Please check and try again.")
        )

        AppTextField(
            placeholder: "Password",
            text: .constant(""),
            state: .idle,
            isSecure: true
        )

        AppTextField(
            placeholder: "Password",
            text: .constant("Sarthak121@"),
            state: .valid,
            isSecure: true
        )

        AppTextField(
            placeholder: "Password",
            text: .constant("abc"),
            state: .error("Your password must be at least 8 characters long and include a mix of letters, numbers, and symbols for security."),
            isSecure: true
        )
    }
    .padding(24)
    .background(Color(white: 0.07))
}
