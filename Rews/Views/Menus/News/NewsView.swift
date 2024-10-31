import SwiftUI

struct NewsView: View {
    @State private var currentArticle: Article?
    
    @StateObject private var articleViewModel = ArticleViewModel()
    
    var body: some View {
        NavigationStack {
            if articleViewModel.isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            } else {
                List(articleViewModel.articles) { article in
                    Button(action: {
                        DispatchQueue.main.async {
                            currentArticle = article
                        }
                    }) {
                        HStack {
                            Image(systemName: "newspaper")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(10)
                                .clipShape(Circle())
                            Text(article.title)
                        }
                    }
                }
                .onAppear {
                    if articleViewModel.articles.isEmpty {
                        articleViewModel.fetchData()
                    }
                }
                .navigationTitle("Notícias")
                .animation(.default, value: articleViewModel.isLoading)
                .sheet(item: $currentArticle) { article in
                    ArticleView(
                        title: article.title,
                        content: article.content,
                        author: article.User.name,
                        publishDate: formatDate(from: article.publishedAt)
                    )
                }
            }
        }
    }
    
    // Function to format the publishedAt date
    func formatDate(from dateString: String?) -> Date {
        guard let dateString = dateString else {
            return Date()
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Example format; adjust to your actual date format
        return formatter.date(from: dateString) ?? Date()
    }
}
//
//#Preview {
//    NewsView()
//}
