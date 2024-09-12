//
//  NewsView.swift
//  Rews
//
//  Created by Gustavo Barros da Silveira on 08/09/24.
//

import SwiftUI

struct NewsView: View {
    let newsItems = [
        "Breaking News: Placeholder content for the latest events.",
        "Placeholder Headline: This is an example news article.",
        "More News: Content goes here.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        "Placeholder Headline: This is an example news article.",
        
    ]
    
    var body: some View {
        NavigationStack {
            List(newsItems, id: \.self) { news in
                Text(news)
            }
            .navigationTitle("Notícias")
        }
        
    }
}


#Preview {
    NewsView()
}
