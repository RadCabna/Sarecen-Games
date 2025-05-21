//
//  Castle.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 20.05.2025.
//

import SwiftUI

struct Castle: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("wreathCount") var wreathCount = 0
    @AppStorage("castleIndex") var castleIndex = 0
    @State private var darckOpacity: CGFloat = 0
    @State private var castleArray = Arrays.castleArray
    @State private var castleData = UserDefaults.standard.array(forKey: "castleData") as? [Int] ?? [0,0,0,0,0]
    
    var body: some View {
        ZStack {
            Background(backgroundNumber: 5)
            HStack {
                Spacer()
                Image("pointFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.2)
                    .overlay(
                        ZStack {
                            Image("coin")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.05)
                                .offset(x:-screenWidth*0.06)
                                .onTapGesture {
//                                    coinCount += 100
                                }
                            Text("\(coinCount)")
                                .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.06))
                                .foregroundColor(Color("textColor"))
                                .offset(x: screenWidth*0.04, y: screenWidth*0.004)
                        }
                    )
                    .padding(.leading, screenWidth*0.08)
                Image("pointFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.2)
                    .overlay(
                        ZStack {
                            Image("wreath")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.05)
                                .offset(x:-screenWidth*0.06, y: -screenWidth*0.002)
                                .onTapGesture {
//                                    wreathCount += 100
                                }
                            Text("\(wreathCount)")
                                .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.06))
                                .foregroundColor(Color("textColor"))
                                .offset(x: screenWidth*0.04, y: screenWidth*0.004)
                        }
                    )
                Spacer()
                Image("homeButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.08)
                    .onTapGesture {
                        closeMenuAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            coordinator.navigate(to: .mainMenu)
                        }
                    }
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        .opacity(darckOpacity)
            HStack {
                ForEach(0..<castleArray.count, id: \.self) { index in
                    VStack(spacing: 0) {
                        Image(castleArray[index].image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.15)
                        Image("castlePlate")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.13)
                            .overlay(
                                Text(castleArray[index].name)
                                    .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.03))
                                    .foregroundColor(Color("textColor"))
                            )
                    }
                    .onTapGesture {
                        castleIndex = index
                        closeMenuAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            coordinator.navigate(to: .castleSettings)
                        }
                    }
                    .offset(y: -screenHeight*castleArray[index].yOffset)
                }
            }
            .offset(y: screenHeight*0.17)
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
    Castle()
}
