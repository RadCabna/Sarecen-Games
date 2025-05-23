//
//  Loading.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 20.05.2025.
//

import SwiftUI

struct Loading: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("levelInfo") var level = false
    @State private var loadingOpacity: CGFloat = 0
    @State private var loadingProgress = 0
    @State private var timer: Timer? = nil
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            let isLandscape = width > height
            if isLandscape {
                ZStack {
                    Background(backgroundNumber: 0)
                    VStack {
                        Image("loadingLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: width*0.25)
                        Image("loadingText")
                            .resizable()
                            .scaledToFit()
                            .frame(width: width*0.6)
                        ZStack {
                            Image("loadingBarBack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width*0.4)
                                .overlay(
                                    HStack(spacing: width*0.008) {
                                        ForEach(0...loadingProgress, id: \.self) { item in
                                            Image("loadingPoint")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: width*0.03)
                                        }
                                    }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, width*0.035)
                                )
                        }
                    }
                    .offset(y: height*0.05)
                    .opacity(loadingOpacity)
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            } else {
                ZStack {
                    Background(backgroundNumber: 0)
                    VStack {
                        Image("loadingLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: height*0.25)
                        Image("loadingText")
                            .resizable()
                            .scaledToFit()
                            .frame(width: height*0.6)
                        ZStack {
                            Image("loadingBarBack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: height*0.4)
                                .overlay(
                                    HStack(spacing: height*0.008) {
                                        ForEach(0...loadingProgress, id: \.self) { item in
                                            Image("loadingPoint")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: height*0.03)
                                        }
                                    }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, height*0.035)
                                )
                        }
                    }
                    .opacity(loadingOpacity)
                    .rotationEffect(Angle(degrees: -90))
                    .offset(x: width*0.05)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }
        }
        
        .onAppear {
            changeLogoShadowRadiusAnimation()
            loadingProgressAnimation()
        }
        
        .onChange(of: loadingProgress) { _ in
            if loadingProgress >= 8 {
                stopTimer()
            }
        }
        
        .onChange(of: level) { _ in
            if level {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    coordinator.navigate(to: .mainMenu)
                }
            }
        }
        
    }
    
    func loadingProgressAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                if loadingProgress < 8 {
                    loadingProgress += 1
                }
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func changeLogoShadowRadiusAnimation() {
        withAnimation(Animation.easeInOut(duration: 1.5)) {
            loadingOpacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            coordinator.navigate(to: .mainMenu)
        }
    }
}

#Preview {
    Loading()
}
