//
//  FinishBonusGame.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 22.05.2025.
//

import SwiftUI

struct FinishBonusGame: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("wreathCount") var wreathCount = 0
    @State private var darckOpacity: CGFloat = 0
    @Binding var wreathBonusCount: Int
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(0.4)
            Image("finishBonusGame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.4)
                .overlay(
                    ZStack {
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
                                    Text("\(wreathBonusCount)")
                                        .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.06))
                                        .foregroundColor(Color("textColor"))
                                        .offset(x: screenWidth*0.04, y: screenWidth*0.004)
                                }
                            )
                            .offset(y: screenWidth*0.04)
                        HStack(spacing: screenWidth*0.04) {
                            Image("nextButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.07)
                                .onTapGesture {
                                    closeMenuAnimation()
                                    wreathCount += wreathBonusCount
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        coordinator.navigate(to: .game)
                                    }
                                }
                            Image("homeButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.07)
                                .onTapGesture {
                                    closeMenuAnimation()
                                    wreathCount += wreathBonusCount
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        coordinator.navigate(to: .mainMenu)
                                    }
                                }
                        }
                        .offset(y: screenWidth*0.17)
                    }
                )
        }
        .opacity(darckOpacity)
        
        .onAppear {
            showMenuAnimation()
            SoundManager.instance.loopSound(sound: "soundWin")
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
    FinishBonusGame(wreathBonusCount: .constant(5))
}
