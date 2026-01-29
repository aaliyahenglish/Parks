//
//  ParkDetailView.swift
//  Parks
//
//  Created by Aaliyah English on 10/26/25.
//

import SwiftUI
import MapKit

struct ParkDetailView: View {
    
    let park: Park
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Park Info Section
                VStack(alignment: .leading, spacing: 16) {
                    Text(park.fullName)
                        .font(.largeTitle)
                    Text(park.description)
                    Text("By Aaliyah English Z23670086")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding()
                
                // Images Section
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(park.images) { image in
                            ParkImageView(image: image)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Map Section
                if let latitude = Double(park.latitude), let longitude = Double(park.longitude) {
                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    Map(initialPosition: .region(.init(center: coordinate, latitudinalMeters: 1_000_000, longitudinalMeters: 1_000_000))) {
                        Marker(park.name, coordinate: coordinate)
                            .tint(.purple)
                    }
                    .aspectRatio(1, contentMode: .fill)
                    .cornerRadius(12)
                    .padding()
                }
            }
        }
        .navigationTitle(park.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ParkImageView: View {
    let image: ParkImage
    
    var body: some View {
        Rectangle()
            .aspectRatio(7/5, contentMode: .fit)
            .containerRelativeFrame(.horizontal, count: 9, span: 8, spacing: 16)
            .overlay {
                AsyncImage(url: URL(string: image.url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color(.systemGray4)
                }
            }
            .cornerRadius(16)
    }
}

#Preview {
    ParkDetailView(park: Park.mocked)
}
