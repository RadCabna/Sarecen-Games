//
//  BonusGame.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 22.05.2025.
//

import SwiftUI

struct BonusGame: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var timer: Timer? = nil
    @State private var elapsedTime = 10
    @State private var darckOpacity: CGFloat = 0
    @State private var wreathCount = 0
    @State private var wrethCorrectOffsetX: CGFloat = 0
    @State private var wrethCorrectOffsetY: CGFloat = 0
    @State private var wrethCorrectCollect = false
    @State private var timerWreth1: Timer? = nil
    @State private var timerWreth2: Timer? = nil
    @State private var timerWreth3: Timer? = nil
    @State private var wrethCorrectOpacity: CGFloat = 0
    @State private var wreth1IncorrectOpacity: CGFloat = 0
    @State private var wreth2IncorrectOpacity: CGFloat = 0
    @State private var wreth1InorrectCollect = false
    @State private var wreth2InorrectCollect = false
    @State private var wreth1IncorrectOffsetX: CGFloat = 0
    @State private var wreth1IncorrectOffsetY: CGFloat = 0
    @State private var wreth2IncorrectOffsetX: CGFloat = 0
    @State private var wreth2IncorrectOffsetY: CGFloat = 0
    @State private var bonusComplete = false
    var body: some View {
        ZStack {
            Background(backgroundNumber: 4)
            ZStack {
                HStack {
                    Image("timerFrame")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.11)
                        .overlay(
                            Text("\(elapsedTime)")
                                .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.06))
                                .foregroundColor(Color("textColor"))
                                .offset(y: screenWidth*0.004)
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
            }
            .opacity(darckOpacity)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            Image("wreathGold")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.07)
                .opacity(wrethCorrectCollect ? 0 : wrethCorrectOpacity)
                .offset(x: wrethCorrectOffsetX*screenWidth, y: wrethCorrectOffsetY*screenWidth)
                .onTapGesture {
                    tapOnCorrectWreath()
                }
            Image("wreathbronze")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.07)
                .opacity(wreth1InorrectCollect ? 0 : wreth1IncorrectOpacity)
                .offset(x: wreth1IncorrectOffsetX*screenWidth, y: wreth1IncorrectOffsetY*screenWidth)
                .onTapGesture {
                    tapOnIncorrectWreath1()
                }
            Image("wreathsilver")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.07)
                .opacity(wreth2InorrectCollect ? 0 : wreth2IncorrectOpacity)
                .offset(x: wreth2IncorrectOffsetX*screenWidth, y: wreth2IncorrectOffsetY*screenWidth)
                .onTapGesture {
                    tapOnIncorrectWreath2()
                }
            
            if bonusComplete {
                FinishBonusGame(wreathBonusCount: $wreathCount)
            }
            
        }
        
        .onChange(of: bonusComplete) { _ in
        if !bonusComplete {
                elapsedTime = 1
            }
        }
        
        .onChange(of: elapsedTime) { _ in
        if elapsedTime <= 0 {
                stopTimer()
            stopWreath1Timer()
            stopWreath2Timer()
            stopWreath3Timer()
            bonusComplete = true
            }
        }
        
        .onAppear {
            SoundManager.instance.loopSound(sound: "soundBonus")
            showMenuAnimation()
            startTimer()
            startCorrectWrethTimer()
            startIncorrectWreth1Timer()
            startIncorrectWreth2Timer()
        }
        
    }
    
    func tapOnCorrectWreath() {
        SoundManager.instance.loopSound(sound: "soundCoin1")
        wrethCorrectCollect = true
        wreathCount += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            wrethCorrectCollect = false
        }
    }
    
    func tapOnIncorrectWreath1() {
//        wrethCorrectCollect = true
        wreathCount = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            wrethCorrectCollect = false
        }
    }
    
    func tapOnIncorrectWreath2() {
//        wrethCorrectCollect = true
        wreathCount = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            wrethCorrectCollect = false
        }
    }
    
    func showAndHideWreth() {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            wrethCorrectOpacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(Animation.easeInOut(duration: 0.2)) {
                wrethCorrectOpacity = 0
            }
        }
    }
    func showAndHideWreth1() {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            wreth1IncorrectOpacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(Animation.easeInOut(duration: 0.2)) {
                wreth1IncorrectOpacity = 0
            }
        }
    }
    func showAndHideWreth2() {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            wreth2IncorrectOpacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(Animation.easeInOut(duration: 0.2)) {
                wreth2IncorrectOpacity = 0
            }
        }
    }
    
    func randomizeCorrectWreathOffset() {
        wrethCorrectOffsetX = .random(in: -0.4...0.4)
        wrethCorrectOffsetY = .random(in: -0.1...0.2)
    }
    func randomizeIncorrectWreath1Offset() {
        wreth1IncorrectOffsetX = .random(in: -0.4...0.4)
        wreth1IncorrectOffsetY = .random(in: -0.1...0.2)
    }
    func randomizeIncorrectWreath2Offset() {
        wreth2IncorrectOffsetX = .random(in: -0.4...0.4)
        wreth2IncorrectOffsetY = .random(in: -0.1...0.2)
    }
    
    func startCorrectWrethTimer() {
        timerWreth1 = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
           randomizeCorrectWreathOffset()
            showAndHideWreth()
        }
    }
    
    func stopWreath1Timer() {
        timerWreth1?.invalidate()
        timerWreth1 = nil
    }
    
    func stopWreath2Timer() {
        timerWreth2?.invalidate()
        timerWreth2 = nil
    }
    
    func stopWreath3Timer() {
        timerWreth3?.invalidate()
        timerWreth3 = nil
    }
    
    func startIncorrectWreth1Timer() {
        timerWreth2 = Timer.scheduledTimer(withTimeInterval: 1.8, repeats: true) { _ in
           randomizeIncorrectWreath1Offset()
            showAndHideWreth1()
        }
    }
    
    func startIncorrectWreth2Timer() {
        timerWreth3 = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
           randomizeIncorrectWreath2Offset()
            showAndHideWreth2()
        }
    }
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                elapsedTime -= 1
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
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
    BonusGame()
}
