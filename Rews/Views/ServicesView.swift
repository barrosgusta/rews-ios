//
//  ServicesView.swift
//  Rews
//
//  Created by Gustavo Barros da Silveira on 08/09/24.
//

import SwiftUI

struct ServicesView: View {
    struct Service: Identifiable {
        let description: String
        let number: String
        let id = UUID()
    }
    
    private var services = [
        Service(description: "Emergência", number: "911"),
        Service(description: "Polícia", number: "190"),
        Service(description: "Bombeiros", number: "193"),
        Service(description: "SAMU", number: "192"),
        Service(description: "Defesa Civil", number: "199"),
        Service(description: "Guarda Municipal", number: "153"),
        Service(description: "Polícia Rodoviária Federal", number: "191"),
        Service(description: "Polícia Rodoviária Estadual", number: "198"),
        Service(description: "Polícia Federal", number: "194"),
        Service(description: "Polícia Civil", number: "197"),
        Service(description: "Polícia Militar", number: "190"),
        Service(description: "Disque Denúncia", number: "181"),
        Service(description: "Corpo de Bombeiros", number: "193")
    ]
    
    var body: some View {
        NavigationStack {
            List(services) { service in
                HStack {
                    Text(service.description)
                    Spacer()
                    Button(action: {
                        callNumber(number: service.number)
                    }) {
                        Text(service.number)
                            .foregroundColor(.blue)
                    }
                }
            }.navigationTitle("Serviços")
        }
    }
    
    private func callNumber(number: String) {
        if let phoneURL = URL(string: "tel://\(number)") {
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }
        }
    }
}

#Preview {
    ServicesView()
}
