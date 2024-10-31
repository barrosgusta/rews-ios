import SwiftUI
import WebKit

// WebView to display YouTube videos
struct VideoView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// YouTubeView to pass the YouTube video URL
struct YouTubeView: View {
    @StateObject private var videoViewModel = VideoViewModel()
        
    var body: some View {
        NavigationStack {
            VStack {
                if videoViewModel.isLoading {
                    ProgressView()
                } else {
                    List(videoViewModel.videos) { video in
                        VideoView(urlString: "https://www.youtube.com/embed/\(video.youtubeVideoId)")
                            .frame(height: 200)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }.navigationTitle("Vídeos")
                }
            }
            
        }
        .animation(.default, value: videoViewModel.isLoading)
        .onAppear {
            if videoViewModel.videos.isEmpty {
                try! videoViewModel.fetchData()
            }
        }
        
    }
}

// Preview for SwiftUI canvas
//#Preview {
//    YouTubeView(videoID: "_WZ9JfST_6w") // Replace with any valid YouTube video ID
//}
