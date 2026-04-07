//
//  AppButton.swift
//  MovieSwiftLearning
//

import SwiftUI

// MARK: - AppButton

// AppButton: primary CTA button — full-width, nền đỏ, chữ trắng
// So sánh với RN: <TouchableOpacity style={styles.primaryButton}>
// So sánh với Flutter: ElevatedButton với custom style
//
// Cách dùng:
//   AppButton(title: "Next") { ... }
//   AppButton(title: "Đăng nhập", horizontalPadding: 32) { ... }

struct AppButton: View {
    let title: String
    var horizontalPadding: CGFloat = 24
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.inter(.headline))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(Color(red: 0.9, green: 0.2, blue: 0.2))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(.horizontal, horizontalPadding)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 16) {
        AppButton(title: "Next") {}
        AppButton(title: "Đăng nhập", horizontalPadding: 32) {}
    }
    .padding(24)
    .background(Color.black)
}
