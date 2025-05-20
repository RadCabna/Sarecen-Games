//
//  MenuButton.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 20.05.2025.
//

import SwiftUI

struct MenuButton: View {
    var size: CGFloat = 0.25
    var text = "BACKGROUND"
    var body: some View {
       Image("buttonFrame")
            .resizable()
            .scaledToFit()
            .frame(width: screenWidth*size)
            .overlay(
                Text(text)
                    .font(Font.custom("Jomhuria-Regular", size: screenWidth*size*0.25))
                    .foregroundColor(Color("textColor"))
                    .offset(y: screenWidth*0.004)
            )
            .shadow(color:.black, radius: 3, x: 2, y: 3)
    }
}

#Preview {
    MenuButton()
}
