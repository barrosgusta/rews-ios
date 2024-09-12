import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsView()
                .tabItem {
                    Label("Notícias", systemImage: "newspaper")
                }
            
            MapView()
                .tabItem {
                    Label("Mapa", systemImage: "map")
                }
            ServicesView()
                .tabItem {
                    Label("Serviços", systemImage: "phone")
                }
        }
    }
}

