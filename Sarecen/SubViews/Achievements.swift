//
//  Achievements.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 22.05.2025.
//

import SwiftUI

struct Achievements: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var darckOpacity: CGFloat = 0
    @State private var achievementsData = UserDefaults.standard.array(forKey: "achievementsData") as? [Int] ?? [0,0,0,0,0]
    @State private var achievementsArray = Arrays.achievementsTextArray
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            Image("homeButton")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.08)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding()
                .onTapGesture {
                    closeMenuAnimation()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        coordinator.navigate(to: .mainMenu)
                    }
                }
                .opacity(darckOpacity)
            VStack(spacing:screenWidth*0.004) {
                ForEach(0..<achievementsArray.count, id:\.self) { item in
                    HStack {
                        Image("achieveFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.65)
                            .overlay(
                                Text(achievementsArray[item].uppercased())
                                    .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.042))
                                    .foregroundColor(Color("textColor"))
                                    .offset(y: screenWidth*0.003)
                            )
                        Image("achieveReward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.1)
                        switch achievementsData[item] {
                        case 0:
                            Image("castleLock")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.06)
                        case 1:
                            Image("castlePlus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.06)
                        default:
                            Image("shopMarkOk")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.06)
                            
                        }
                    }
                }
            }
            .offset(x: -screenWidth*0.015, y: screenWidth*0.05)
            .opacity(darckOpacity)
        }
        
        .onAppear {
            showMenuAnimation()
        }
        
    }
    
    func showMenuAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.2)) {
            darckOpacity = 1
        }
    }
    
    func closeMenuAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.2)) {
            darckOpacity = 0
        }
    }
    
}

#Preview {
    Achievements()
}
