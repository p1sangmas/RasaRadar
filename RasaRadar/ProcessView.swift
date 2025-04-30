//
//  ProcessView.swift
//  RasaRadar
//
//  Created by AUTHOR_NAME on 03/04/2025.
//

import SwiftUI
import AVFoundation
import Vision
import CoreML

struct ProcessView: View {
    @State private var isCameraPresented = false
    @State private var capturedImage: UIImage? = nil
    @State private var classificationResult: String? = nil
    
    // Mock data for food information
    private let foodInfo: [String: (calories: Int, description: String)] = [
        "Fried Noodles": (calories: 500, description: "Fried Noodles are stir-fried noodles with vegetables, meat, or seafood."),
        "Fried Rice": (calories: 450, description: "Fried Rice is a popular dish made with stir-fried rice, eggs, and vegetables."),
        "Kaya Toast": (calories: 300, description: "Kaya Toast is a traditional breakfast dish made with toasted bread and kaya jam."),
        "Laksa": (calories: 600, description: "Laksa is a spicy noodle soup with a rich coconut milk base."),
        "Nasi Lemak": (calories: 644, description: "Nasi Lemak is a traditional Malaysian dish made with fragrant rice cooked in coconut milk, served with sambal, anchovies, peanuts, and boiled eggs."),
        "Popiah": (calories: 200, description: "Popiah is a fresh spring roll filled with vegetables, meat, and sauces."),
        "Roti Canai": (calories: 300, description: "Roti Canai is a flaky flatbread commonly served with dhal curry or other side dishes in Malaysia."),
        "Satay": (calories: 250, description: "Satay is a dish of skewered and grilled meat served with peanut sauce.")
    ]
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Title
            VStack(spacing: 10) {
                Text("Scan and Classify")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Take a photo of your food to classify it!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Display captured image (if available)
            if let image = capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 5)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .frame(width: 300, height: 300)
                    .overlay(
                        Text("No Image")
                            .foregroundColor(.secondary)
                            .font(.headline)
                    )
            }
            
            // Capture Button
            Button(action: {
                isCameraPresented = true
            }) {
                HStack {
                    Image(systemName: "camera.viewfinder")
                        .font(.title2)
                    Text("Scan Food")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .padding()
                .frame(maxWidth: 250)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .padding(.horizontal, 40)
            .sheet(isPresented: $isCameraPresented) {
                CameraCaptureView(capturedImage: $capturedImage, classificationResult: $classificationResult)
            }
            
            // Display classification result
            if let result = classificationResult {
                let formattedResult = formatResult(result)
                Text("Result: \(formattedResult)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                            .shadow(radius: 5)
                    )
                    .padding(.horizontal, 20)
                
                // Navigate to FoodInfoView
                if let foodDetails = foodInfo[formattedResult] {
                    NavigationLink(destination: FoodInfoView(foodName: formattedResult, calories: foodDetails.calories, description: foodDetails.description)) {
                        Text("View Food Info")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: 250)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(color: .green.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 40)
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    // Helper function to format the classification result
    private func formatResult(_ result: String) -> String {
        return result
            .replacingOccurrences(of: "_", with: " ") // Replace underscores with spaces
            .split(separator: " ") // Split into words
            .map { $0.capitalized } // Capitalize each word
            .joined(separator: " ") // Join the words back with spaces
    }
}

#Preview {
    ProcessView()
}
