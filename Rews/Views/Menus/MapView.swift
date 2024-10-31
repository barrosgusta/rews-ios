//
//  MapView.swift
//  Rews
//
//  Created by Gustavo Barros da Silveira on 08/09/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    let locationManager = CLLocationManager()
    
    @StateObject private var shelterViewModel = ShelterViewModel()
    @State private var mainTownRegion: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 0,
            longitude: 0
        ),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    ))
    @State private var selection: Int?
    
    var body: some View {
        ZStack {
            if shelterViewModel.isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            } else {
                Map(position: $mainTownRegion, selection: $selection) {
                    ForEach(shelterViewModel.shelters) {shelter in
                        let shelterCoordinate = CLLocationCoordinate2D(latitude: shelter.latitude, longitude: shelter.longitude)
                        Marker(shelter.name, coordinate: shelterCoordinate)
                    }
                }
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                    MapScaleView()
                }
                .safeAreaInset(edge: .bottom) {
                    HStack {
                        Spacer()
                        if let selection {
                            VStack(spacing: 0) {
                                if let item = shelterViewModel.shelters.first(where: { $0.id == selection }) {
                                    ShelterInfoView(selectedResult: item)
                                }
                                
                            }
                            .padding(20)
                        }
                        Spacer()
                    }
                    .background(.thinMaterial)
                    .transition(.move(edge: .bottom))
                }
                .onChange(of: selection) {
                    if let selection, let item = shelterViewModel.shelters.first(where: { $0.id == selection }) {
                        // Handle selection change if needed
                    }
                    guard let selection else {
                        return
                    }
                    guard let item = shelterViewModel.shelters
                        .first(
                            where: { $0.id == selection }
                        ) else { return }
                }
            }
        }
        .animation(.interactiveSpring, value: shelterViewModel.isLoading)
        .task {
            locationManager.requestWhenInUseAuthorization()
            if shelterViewModel.shelters.isEmpty {
                try! shelterViewModel.fetchShelters()
                
            }
            if shelterViewModel.mainTown == nil {
                try! shelterViewModel.fetchSheltersMainTown { result in
                    switch result {
                    case .success(let shelterMainTown):
                        DispatchQueue.main.async {
                            let latitude = Double(shelterMainTown.latitude) ?? 0
                            let longitude = Double(shelterMainTown.longitude) ?? 0
                            
                            self.mainTownRegion = MapCameraPosition.region(MKCoordinateRegion(
                                center: CLLocationCoordinate2D(
                                    latitude: latitude,
                                    longitude: longitude
                                ),
                                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                            ))
                        }
                    case .failure(let error):
                        print("Failed to fetch Main Town:", error)
                    }
                }
            }
        }
    }
}

struct ShelterInfoView: View {
    var selectedResult: Shelter
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "house")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(10)
                    .clipShape(Circle())
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(selectedResult.name)
                        .font(.headline)
                    Text(selectedResult.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            
            Divider()
            
            HStack {
                Image(systemName: "mappin.and.ellipse")
                Text(selectedResult.address)
            }
            .padding()
        
            Button(action: {
                let shelterCoordinate = CLLocationCoordinate2D(latitude: selectedResult.latitude, longitude: selectedResult.longitude)
                let mapItem = MKMapItem(
                    placemark: MKPlacemark(coordinate: shelterCoordinate)
                )
                mapItem.name = selectedResult.name
                mapItem.openInMaps()
            }) {
                Text("Ver no \(Text("\u{f8ff}")) Maps")
                    .padding()
                    .background(.mint.opacity(0.2))
                    .cornerRadius(10)
            }
        }
    }
    
}

//#Preview {
//    MapView()
//}
