//
//  WinMiniGame.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 22.05.2025.
//

import SwiftUI

struct WinMiniGame: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @State private var darckOpacity: CGFloat = 0
    @Binding var youWin: Bool
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(0.4)
            Image("winMiniGameFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.4)
                .overlay(
                    HStack(spacing: screenWidth*0.04) {
                        Image("restartButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.07)
                            .onTapGesture {
                                closeMenuAnimation()
                                coinCount += 20
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    youWin.toggle()
                                }
                            }
                        Image("homeButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.07)
                            .onTapGesture {
                                closeMenuAnimation()
                                coinCount += 20
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    coordinator.navigate(to: .mainMenu)
                                }
                            }
                    }
                        .offset(y: screenWidth*0.17)
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
    WinMiniGame(youWin: .constant(true))
}
