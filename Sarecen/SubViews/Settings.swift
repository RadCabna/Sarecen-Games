//
//  Settings.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 20.05.2025.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("soundVolume") var soundVolume: Double = 0.5
    @AppStorage("musicVolume") var musicVolume: Double = 0.5
    @State private var soundLevel: Double = 6
    @State private var musicLevel: Double = 6
    @State private var darckOpacity: CGFloat = 0
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        coordinator.navigate(to: .mainMenu)
                    }
                }
                .opacity(darckOpacity)
            Image("optionsFrame")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.32)
                .overlay(
                    VStack(spacing: 0) {
                        Text("MUSIC")
                            .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.07))
                            .foregroundColor(Color("textColor"))
                        HStack {
                            Image("minusButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.03)
                                .onTapGesture {
                                    tapMinus(setting: &musicLevel, storageSettings: &musicVolume)
                                }
                            Image("loadingBarBack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.14)
                                .overlay(
                                    HStack(spacing: screenWidth*0.002) {
                                        ForEach(0...Int(musicLevel), id: \.self) { item in
                                            if musicLevel > 0 {
                                                Image("loadingPoint")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.008)
                                            }
                                        }
                                    }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, screenWidth*0.01)
                                )
                            Image("plusButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.03)
                                .onTapGesture {
                                    tapPlus(setting: &musicLevel, storageSettings: &musicVolume)
                                }
                        }
                        Text("SOUND")
                            .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.07))
                            .foregroundColor(Color("textColor"))
                            .padding(.top)
                        HStack {
                            Image("minusButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.03)
                                .onTapGesture {
                                    tapMinus(setting: &soundLevel, storageSettings: &soundVolume)
                                }
                            Image("loadingBarBack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.14)
                                .overlay(
                                    HStack(spacing: screenWidth*0.002) {
                                        ForEach(0...Int(soundLevel), id: \.self) { item in
                                                Image("loadingPoint")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.008)
                                        }
                                    }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, screenWidth*0.01)
                                )
                            Image("plusButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.03)
                                .onTapGesture {
                                    tapPlus(setting: &soundLevel, storageSettings: &soundVolume)
                                }
                        }
                    }
                )
                .opacity(darckOpacity)
        }
        
        
        .onChange(of: musicVolume) { _ in
            SoundManager.instance.updateMusicVolume()
        }
        
        .onAppear {
            showMenuAnimation()
            soundLevel = soundVolume*10
            musicLevel = musicVolume*10
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
    
    func tapPlus(setting: inout Double, storageSettings: inout Double) {
        if setting < 11 {
            setting += 1
            storageSettings += 0.1
        }
    }
    
    func tapMinus(setting: inout Double, storageSettings: inout Double) {
        if setting > 0 {
            setting -= 1
            storageSettings -= 0.1
        }
    }
    
}

#Preview {
    Settings()
}
