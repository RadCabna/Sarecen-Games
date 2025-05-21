//
//  CastleSettings.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 21.05.2025.
//

import SwiftUI

struct CastleSettings: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("wreathCount") var wreathCount = 0
    @AppStorage("castleIndex") var castleIndex = 0
    @State private var castleData = UserDefaults.standard.array(forKey: "castleData") as? [Int] ?? [0,0,0,0,0]
    @State private var castleArray = Arrays.castleArray
    @State private var darckOpacity: CGFloat = 0
    @State private var castleUpgradeInfo = Arrays.castleUpgradeInfo
    
    var body: some View {
        ZStack {
            Background(backgroundNumber: 5)
            Image("homeButton")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.08)
                .onTapGesture {
                    closeMenuAnimation()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        coordinator.navigate(to: .castle)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding()
                .opacity(darckOpacity)
            ZStack {
                Image("castleInfoFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.6)
                Image("castlePlate")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.14)
                    .overlay(
                        Text(castleArray[castleIndex].name)
                            .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.03))
                            .foregroundColor(Color("textColor"))
                    )
                    .offset(y: -screenWidth*0.17)
            }
            .overlay(
                VStack(spacing: screenWidth*0.005) {
                    Text("LEVEL \(castleData[castleIndex] + 1)")
                        .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.08))
                        .foregroundColor(Color("textColor"))
                    Text(castleArray[castleIndex].text.uppercased())
                        .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.03))
                        .foregroundColor(Color("textColor"))
                        .lineLimit(nil)
                        .lineSpacing(-30)
                        .fixedSize(horizontal: false, vertical: false)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: screenWidth*0.5)
                    ZStack {
                        HStack {
                            Text("INCOME")
                                .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.04))
                                .foregroundColor(Color("textColor"))
                            Spacer()
                            Text("/DAY")
                                .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.04))
                                .foregroundColor(Color("textColor"))
                        }
                        .frame(maxWidth: screenWidth*0.45)
                        HStack {
                            Image("pointFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.14)
                                .overlay(
                                    ZStack {
                                        Image("coin")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenWidth*0.03)
                                            .offset(x:-screenWidth*0.043)
                                        Text("\(castleUpgradeInfo[castleData[castleIndex]].costCoin)")
                                            .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.05))
                                            .foregroundColor(Color("textColor"))
                                            .offset(x: screenWidth*0.03, y: screenWidth*0.004)
                                    }
                                )
                            Image("pointFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.14)
                                .overlay(
                                    ZStack {
                                        Image("wreath")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenWidth*0.03)
                                            .offset(x:-screenWidth*0.043)
                                        Text("\(castleUpgradeInfo[castleData[castleIndex]].costWreth)")
                                            .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.05))
                                            .foregroundColor(Color("textColor"))
                                            .offset(x: screenWidth*0.03, y: screenWidth*0.004)
                                    }
                                )
                        }
                    }
                    ZStack {
                        HStack {
                            Text("COST")
                                .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.04))
                                .foregroundColor(Color("textColor"))
                            Spacer()
                            if coinCount >= castleUpgradeInfo[castleData[castleIndex]].incCoin &&
                                wreathCount >= castleUpgradeInfo[castleData[castleIndex]].incWreth {
                                Image("castlePlus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.04)
                                    .onTapGesture {
                                        updateCastle()
                                    }
                            } else {
                                Image("castleLock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.04)
                            }
                        }
                        .frame(maxWidth: screenWidth*0.45)
                        HStack {
                            Image("pointFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.14)
                                .overlay(
                                    ZStack {
                                        Image("coin")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenWidth*0.03)
                                            .offset(x:-screenWidth*0.043)
                                        Text("\(castleUpgradeInfo[castleData[castleIndex]].incCoin)")
                                            .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.05))
                                            .foregroundColor(Color("textColor"))
                                            .offset(x: screenWidth*0.03, y: screenWidth*0.004)
                                    }
                                )
                            Image("pointFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.14)
                                .overlay(
                                    ZStack {
                                        Image("wreath")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenWidth*0.03)
                                            .offset(x:-screenWidth*0.043)
                                        Text("\(castleUpgradeInfo[castleData[castleIndex]].incWreth)")
                                            .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.05))
                                            .foregroundColor(Color("textColor"))
                                            .offset(x: screenWidth*0.03, y: screenWidth*0.004)
                                    }
                                )
                        }
                    }
                }
            )
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
    
    func updateCastle() {
        if castleData[castleIndex] < 4 {
            coinCount -= castleUpgradeInfo[castleData[castleIndex]].incCoin
            wreathCount -= castleUpgradeInfo[castleData[castleIndex]].incWreth
            UserDefaults.standard.set(castleData, forKey: "castleData")
            castleData[castleIndex] += 1
        }
    }
    
}

#Preview {
    CastleSettings()
}


