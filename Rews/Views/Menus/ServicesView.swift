//
//  ServicesView.swift
//  Rews
//
//  Created by Gustavo Barros da Silveira on 08/09/24.
//

import SwiftUI

struct ServicesView: View {
    @StateObject private var servicePhoneViewModel = ServicePhoneViewModel()
    
    var body: some View {
        NavigationStack {
            if servicePhoneViewModel.isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            } else {
                List(servicePhoneViewModel.servicePhones) { servicePhone in
                    HStack {
                        Text(servicePhone.description)
                        Spacer()
                        Button(action: {
                            callNumber(number: servicePhone.phone)
                        }) {
                            Text(servicePhone.phone)
                                .foregroundColor(.blue)
                        }
                    }
                }.navigationTitle("Serviços")
            }
        }
        .animation(.default, value: servicePhoneViewModel.isLoading)
        .onAppear() {
            if servicePhoneViewModel.servicePhones.isEmpty {
                try! servicePhoneViewModel.fetchData()
            }
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
