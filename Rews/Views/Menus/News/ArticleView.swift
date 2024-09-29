//
//  ArticleView.swift
//  Rews
//
//  Created by Gustavo Barros da Silveira on 12/09/24.
//

import SwiftUI

struct ArticleView: View {
    var title: String
    var content: String
    var author: String
    var publishDate: Date

    // Date Formatter
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: publishDate)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Por \(author)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(formattedDate)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Divider()

            ScrollView {
                Text(.init(content))
                    .font(.body)
            }
        }
        .padding(Edge.Set.horizontal, 24)
        .padding(Edge.Set.top, 24)
    }
}

//#Preview {
//    ArticleView()
//}
