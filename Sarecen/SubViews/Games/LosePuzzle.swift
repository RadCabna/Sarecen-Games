//
//  LosePuzzle.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 21.05.2025.
//

import SwiftUI

struct LosePuzzle: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var darckOpacity: CGFloat = 0
    @Binding var youLose: Bool
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(0.4)
            Image("losePuzzleFrame")
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
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    youLose.toggle()
                                }
                            }
                        Image("homeButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.07)
                            .onTapGesture {
                                closeMenuAnimation()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    coordinator.navigate(to: .mainMenu)
                                }
                            }
                    }
                        .offset(y: screenWidth*0.15)
                )
        }
        .opacity(darckOpacity)
        
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
    LosePuzzle(youLose: .constant(true))
}
