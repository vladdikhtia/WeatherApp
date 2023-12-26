//
//  HomeView.swift
//  WeatherApp
//
//  Created by Vladyslav Dikhtiaruk on 26/12/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weatherResponse : ResponseBody?
    var body: some View {
        VStack{
            if let location = locationManager.location {
//                Text("Longtitude: \(location.longitude), Latitude: \(location.latitude)")
                if let weather = weatherResponse {
                    Text("Weather fetched!")
                } else {
                    ProgressView()
                        .task {
                            do {
                                weatherResponse = try await weatherManager.getCurrentWeather(latitude: location.latitude, longtitude: location.longitude)
                            } catch {
                                print("Something went wrong!\(error)")
                            }
                        }
                }
            } else {
                    if (locationManager.isLoading) {
                        ProgressView()
                    } else {
                        WelcomeView()
                            .environmentObject(locationManager)
                    }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [Color("light"), Color("dark")], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

#Preview {
    HomeView()
}
