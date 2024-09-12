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
    
    @State private var selection: UUID?
    @State private var isAnimating = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -27.216051575512477, longitude: -49.64295574622379),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    let sheltersMapMarkers = [
        ShelterInfo(
            icon: "house",
            name: "Abrigo 1",
            description: "Abrigo para pessoas em situação de rua",
            address: "Rua dos Bobos, nº 0",
            coordinate: CLLocationCoordinate2D(latitude: -27.216051575512477, longitude: -49.54295574622379)
        ),
    ]
    
    //    let unsafeAreas = [
    //        UnsafeArea(
    //            name: "Area de risco 1",
    //            coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
    //            polygon: MKPolygon(coordinates: [CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)], count: 1)
    //        ),
    //        UnsafeArea(
    //            name: "Area de risco 2",
    //            coordinate: CLLocationCoordinate2D(latitude: 37.7849, longitude: -122.4294),
    //        )
    //    ]
    
    var body: some View {
        //        Map(initialPosition: MapCameraPosition.region(region)) {
        Map(initialPosition: MapCameraPosition.region(region), selection: $selection) {
            ForEach(sheltersMapMarkers) {marker in
                Marker(marker.name, coordinate: marker.coordinate)
            }
            //            ForEach(sheltersMapMarkers) { marker in
            //                Annotation(marker.name, coordinate: marker.coordinate, content: {
            //                    ZStack {
            //                        Image(systemName: marker.icon).padding(10)
            //                    }
            //                    .frame(width: 30, height: 30)
            //                    .background(Color.white)
            //                    .cornerRadius(15)
            //                    .shadow(radius: 5)
            //                    }
            //                })
            //            }
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
                        if let item = sheltersMapMarkers.first(where: { $0.id == selection }) {
                            ShelterInfoView(selectedResult: item)
                        }
                        
                    }
                    .padding(20)
                }
                Spacer()
            }
            .background(.thinMaterial)
            .offset(y: isAnimating ? 0 : 400)
        }
        .onChange(of: selection) {
            guard let selection else {
                withAnimation(.snappy) {
                    isAnimating.toggle()
                }
                return
            }
            guard let item = sheltersMapMarkers
                .first(
                    where: { $0.id == selection }
                ) else { return }
            
            withAnimation(.interactiveSpring) {
                isAnimating.toggle()
            }
            
            print(item.coordinate)
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

struct ShelterInfoView: View {
    var selectedResult: ShelterInfo
    
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
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: selectedResult.coordinate))
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

struct ShelterInfo: Identifiable, Equatable {
    let id = UUID()
    let icon: String
    let name: String
    let description: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    static func == (lhs: ShelterInfo, rhs: ShelterInfo) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Area: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: [CLLocationCoordinate2D]
}

#Preview {
    MapView()
}
