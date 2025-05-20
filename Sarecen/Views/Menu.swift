//
//  Menu.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 20.05.2025.
//

import SwiftUI

struct Menu: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("wreathCount") var wreathCount = 0
    @State private var angle: Double = -90
    @State private var angle1: Double = -90
    @State private var darckOpacity: CGFloat = 0
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            VStack {
                HStack {
                    Image("shopButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.08)
                        .onTapGesture {
                            closeMenuAnimation()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                coordinator.navigate(to: .selectShopItem)
                            }
                        }
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
                    Image("settingsButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.08)
                        .onTapGesture {
                            closeMenuAnimation()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                coordinator.navigate(to: .settings)
                            }
                        }
                    
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding()
            }
            .opacity(darckOpacity)
            VStack(spacing: screenWidth*0.02) {
                MenuButton(size: 0.3, text:"PLAY")
                    .offset(y: screenWidth*0.05)
                    .rotation3DEffect(
                        .degrees(angle),
                        axis: (x: 1, y: 0, z: 0)
                    )
                    .offset(y: -screenWidth*0.05)
                    .onTapGesture {
                        closeMenuAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            coordinator.navigate(to: .choseGame)
                        }
                    }
                MenuButton(size: 0.3, text:"MY PALACE")
                    .offset(y: screenWidth*0.05)
                    .rotation3DEffect(
                        .degrees(angle1),
                        axis: (x: 1, y: 0, z: 0)
                    )
                    .offset(y: -screenWidth*0.05)
                    .onTapGesture {
                        closeMenuAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            coordinator.navigate(to: .castle)
                        }
                    }
                HStack {
                    Image("miniGamesButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.08)
                    Image("achievementsButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.08)
                }
            }
            .offset(y: screenHeight*0.12)
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
    Menu()
}
