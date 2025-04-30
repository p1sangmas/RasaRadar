//
//  ContentView.swift
//  RasaRadar
//
//  Created by AUTHOR_NAME on 03/04/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Spacer()
                // Title and Description
                VStack(spacing: 10) {
                    Label("", systemImage: "fork.knife")
                        .font(.title)
                    
                    Text("RasaRadar")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("Discover and classify your favorite Malaysian foods!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 50)
                
                Spacer()
                
                // Navigate to ProcessView
                NavigationLink(destination: ProcessView()) {
                    HStack {
                        Image(systemName: "arrowshape.right.circle.fill")
                            .font(.title)
                        Text("Let's Start!")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(maxWidth: 250)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal, 40)
                
                Spacer()
                
                // Footer
                HStack {
                    Image(systemName: "info.circle")
                    Text("Powered by CoreML & Vision")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    ContentView()
}
