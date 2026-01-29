//
//  ContentView.swift
//  Parks
//
//  Created by Aaliyah English on 10/25/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var parks: [Park] = []
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack{
                    ForEach(parks) { park in
                        NavigationLink(destination: ParkDetailView(park: park)) {
                            ParkRow(park: park)
                        }
                    }
                }
            }
            .navigationTitle("National Parks")
            .padding()
            .onAppear(perform: {
            
            Task {
                let url = URL(string: "https://developer.nps.gov/api/v1/parks?stateCode=wa&api_key=JE3N8lSunFf1xncpnHARAmgBcVGRQVr7MlCtxzfZ")!
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    
                    let parksResponse = try JSONDecoder().decode(ParksResponse.self, from: data)
                    
                    let parks = parksResponse.data
                    
                    for park in parks {
                        print(park.fullName)
                    }
                    
                    self.parks = parks
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
            })
        }
    }
}

#Preview {
    ContentView()
}
