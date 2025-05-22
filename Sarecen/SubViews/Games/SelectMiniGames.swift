//
//  SelectMiniGames.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 22.05.2025.
//

import SwiftUI

struct SelectMiniGames: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("wreathCount") var wreathCount = 0
    @AppStorage("shopType") var shopType = 1
    @State private var angle: Double = -90
    @State private var angle1: Double = -90
    @State private var angle2: Double = -90
    @State private var angle3: Double = -90
    @State private var darckOpacity: CGFloat = 0
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
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
            HStack(spacing: screenWidth*0.06) {
                VStack(spacing: screenWidth*0.02) {
                    MenuButton(size: 0.3, text:"GUES NUMBER")
                        .offset(y: screenWidth*0.05)
                        .rotation3DEffect(
                            .degrees(angle),
                            axis: (x: 1, y: 0, z: 0)
                        )
                        .offset(y: -screenWidth*0.05)
                        .onTapGesture {
                            shopType = 1
                            closeMenuAnimation()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                coordinator.navigate(to: .minGame1)
                            }
                        }
                    MenuButton(size: 0.3, text:"FIND A PAIR")
                        .offset(y: screenWidth*0.05)
                        .rotation3DEffect(
                            .degrees(angle1),
                            axis: (x: 1, y: 0, z: 0)
                        )
                        .offset(y: -screenWidth*0.05)
                        .onTapGesture {
                            shopType = 2
                            closeMenuAnimation()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                coordinator.navigate(to: .minGame2)
                            }
                        }
                }
                VStack(spacing: screenWidth*0.02) {
                    MenuButton(size: 0.3, text:"MEMORY AID")
                        .offset(y: screenWidth*0.05)
                        .rotation3DEffect(
                            .degrees(angle2),
                            axis: (x: 1, y: 0, z: 0)
                        )
                        .offset(y: -screenWidth*0.05)
                        .onTapGesture {
                            shopType = 1
                            closeMenuAnimation()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                coordinator.navigate(to: .minGame3)
                            }
                        }
                    MenuButton(size: 0.3, text:"LABYRINTH")
                        .offset(y: screenWidth*0.05)
                        .rotation3DEffect(
                            .degrees(angle3),
                            axis: (x: 1, y: 0, z: 0)
                        )
                        .offset(y: -screenWidth*0.05)
                        .onTapGesture {
                            shopType = 2
                            closeMenuAnimation()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                coordinator.navigate(to: .minGame4)
                            }
                        }
                }
            }
            .padding(.top, screenWidth*0.1)
            .opacity(darckOpacity)
        }
        
        .onAppear {
            showMenuAnimation()
            buttonAnimation(delay: 0, angle: $angle)
            buttonAnimation(delay: 0.2, angle: $angle1)
            buttonAnimation(delay: 0.3, angle: $angle2)
            buttonAnimation(delay: 0.4, angle: $angle3)
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
    SelectMiniGames()
}
