//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Vladyslav Dikhtiaruk on 26/12/2023.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack{
            VStack(spacing: 20){
                Text("Welcome to the Weather App")
                    .font(.title)
                    .bold()
                
                Text("Please share your location to get the weather in your area")
                    .font(.headline)
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation){
                locationManager.requestLocation()
            }
            .cornerRadius(20)
           // .foregroundStyle(.white)
            
        }
    }
}

#Preview {
    WelcomeView()
}
