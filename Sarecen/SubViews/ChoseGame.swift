//
//  ChoseGame.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 20.05.2025.
//

import SwiftUI

struct ChoseGame: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var darckOpacity: CGFloat = 0
    @State private var angle: Double = -90
    @State private var angle1: Double = -90
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
            VStack(spacing: screenWidth*0.02) {
                MenuButton(size: 0.3, text:"THRONEFALL")
                    .offset(y: screenWidth*0.05)
                    .rotation3DEffect(
                        .degrees(angle),
                        axis: (x: 1, y: 0, z: 0)
                    )
                    .offset(y: -screenWidth*0.05)
                MenuButton(size: 0.3, text:"PUZZLE CLASH")
                    .offset(y: screenWidth*0.05)
                    .rotation3DEffect(
                        .degrees(angle1),
                        axis: (x: 1, y: 0, z: 0)
                    )
                    .offset(y: -screenWidth*0.05)
            }
            .opacity(darckOpacity)
        }
        
        .onAppear {
            showMenuAnimation()
            buttonAnimation(delay: 0, angle: $angle)
            buttonAnimation(delay: 0.2, angle: $angle1)
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
    
    func buttonAnimation(delay: CGFloat, angle: Binding<Double>) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation(Animation.spring(duration: 1)) {
                angle.wrappedValue = 50
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(Animation.spring(duration: 1)) {
                    angle.wrappedValue = -20
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(Animation.spring(duration: 1)) {
                    angle.wrappedValue = 20
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(Animation.spring(duration: 1)) {
                    angle.wrappedValue = -10
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(Animation.spring(duration: 1)) {
                    angle.wrappedValue = 0
                }
            }
        }
    }
    
}

#Preview {
    ChoseGame()
}
