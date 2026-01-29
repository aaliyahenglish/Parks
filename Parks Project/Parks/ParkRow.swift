//
//  ParkRow.swift
//  Parks
//
//  Created by Aaliyah English on 10/26/25.
//

import SwiftUI

struct ParkRow: View {
    
    
    let park: Park
    
    
    var body: some View {
        
        // Park row
        Rectangle()
            .aspectRatio(4/3, contentMode: .fit)
            .overlay {
                let image = park.images.first
                let urlString = image?.url
                let url = urlString.flatMap { string in
                    URL(string: string)
                }
                
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color(.systemGray4)
                }
            }
            .overlay(alignment: .bottomLeading) {
                Text(park.name)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
            }
            .cornerRadius(16)
            .padding(.horizontal)
    }
}
