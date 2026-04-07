//
//  PosterCell.swift
//  MovieSwiftLearning
//

import SwiftUI

// PosterCell: hiển thị một poster phim từ URL với loading/error state
struct PosterCell: View {
    let urlString: String

    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .success(let image):
                image.resizable().scaledToFill()
            case .failure:
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
            default:
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.06))
                    .overlay(ProgressView().tint(.white))
            }
        }
        .frame(width: 88, height: 130)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct PosterRow: View {
    let paths: [String]
    let offset: CGFloat
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(paths, id: \.self) { path in
                PosterCell(urlString: "https://image.tmdb.org/t/p/w500\(path)")
            }
        }
        .offset(x: offset)
    }
}

#Preview {
    HStack(spacing: 12) {
        PosterCell(urlString: "https://image.tmdb.org/t/p/w500/xOMo8BRK7PfcJv9JCnx7s5hj0NX.jpg")
        PosterCell(urlString: "https://invalid-url")
    }
    .padding()
    .background(Color.black)
}

#Preview {
    let posterRow1: [String] = [
        "/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg",
        "/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg",
        "/kCGlIMHnOm8JPXNbM7BHhpfzgsD.jpg",
        "/hUu9zyZmKuWrSVHFvJJAGKhmkHe.jpg",
    ]
    let rowNums = Array(0...3)
    
    VStack{
        ForEach(rowNums, id: \.self) { idx in
            PosterRow(paths: posterRow1, offset: CGFloat(idx * 20))
        }
    }
    .background(.gray)
    .padding()
}
