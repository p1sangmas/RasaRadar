//
//  FoodInfoView.swift
//  RasaRadar
//
//  Created by Fakhrul Fauzi on 03/04/2025.
//

import SwiftUI

struct FoodInfoView: View {
    let foodName: String
    let calories: Int
    let description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Food Name
            Text(foodName)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            // Calories
            Text("\(calories) kcal")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            
            // Description
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                )
                .padding(.horizontal, 20)
            
            Spacer()
            
            // Back Button
            Button(action: {
                // Dismiss the view
            }) {
                Text("Back")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: 250)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .padding(.horizontal, 40)
        }
        .padding()
    }
}

#Preview {
    FoodInfoView(foodName: "Nasi Lemak", calories: 644, description: "Nasi Lemak is a traditional Malaysian dish made with fragrant rice cooked in coconut milk, served with sambal, anchovies, peanuts, and boiled eggs.")
}
