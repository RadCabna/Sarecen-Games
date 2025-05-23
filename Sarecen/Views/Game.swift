//
//  Game.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 20.05.2025.
//

import SwiftUI

struct Game: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var achievementsData = UserDefaults.standard.array(forKey: "achievementsData") as? [Int] ?? [0,0,0,0,0]
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("wreathCount") var wreathCount = 0
    @AppStorage("bgNumber") var bgNumber = 3
    @State private var timer: Timer? = nil
    @State private var coinTimer: Timer? = nil
    @State private var wreathTimer: Timer? = nil
    @State private var checkTimer: Timer? = nil
    @State private var darckOpacity: CGFloat = 0
    @State private var kingXOffset: CGFloat = 0
    @State private var kingYOffset: CGFloat = 0
    @State private var kingRotation: CGFloat = 0
    @State private var gameItemsArray = Arrays.gameItemsArray
    @State private var dropCoin = Arrays.dropCoin
    @State private var dropWreath = Arrays.dropWreath
    var body: some View {
        ZStack {
            Background(backgroundNumber: bgNumber)
            ZStack {
                ForEach(0..<gameItemsArray.count, id: \.self) { index in
                    Image(gameItemsArray[index].name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.08)
                        .opacity(gameItemsArray[index].opacity)
                        .offset(x: gameItemsArray[index].xOffset*screenWidth, y:gameItemsArray[index].yOffset*screenHeight)
                        
                }
                Image(dropCoin.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.04)
                    .opacity(dropCoin.opacity)
                    .offset(x: dropCoin.xOffset*screenWidth, y:dropCoin.yOffset*screenHeight)
                Image(dropWreath.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.06)
                    .opacity(dropWreath.opacity)
                    .offset(x: dropWreath.xOffset*screenWidth, y:dropWreath.yOffset*screenHeight)
            }
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
                                .onTapGesture {
                                    //                                    coinCount += 100
                                }
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
                        stopTimer()
                        stopCoinTimer()
                        stopWreathTimer()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            coordinator.navigate(to: .mainMenu)
                        }
                    }
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .opacity(darckOpacity)
            HStack {
                Image("arrowLeft")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.08)
                    .onTapGesture {
                        moveKingLeft()
                    }
                Spacer()
                Image("arrowLeft")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.08)
                    .scaleEffect(x: -1)
                    .onTapGesture {
                        moveKingRight()
                    }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.horizontal, screenHeight*0.01)
            Image("king")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.12)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: kingYOffset*screenHeight)
                .rotationEffect(Angle(degrees: kingRotation))
                .offset(y: -kingYOffset*screenHeight)
                .offset(x: screenWidth*kingXOffset, y: kingYOffset*screenHeight)
                .ignoresSafeArea()
//            Image("gameItem1")
//                .resizable()
//                .scaledToFit()
//                .frame(width: screenWidth*0.08)
//                .offset(x: screenWidth*0, y: screenHeight*0.25)
//           
                
        }
        
        .onAppear {
            showMenuAnimation()
            startTimer()
            startCheckTimer()
            startCoinTimer()
            startWreathTimer()
        }
        
    }
    
    func dropItems() {
        let xOffsetsArray = [-0.3, -0.2, -0.1, 0, 0.1, 0.2, 0.3]
        for i in 0..<gameItemsArray.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + gameItemsArray[i].delay) {
                gameItemsArray[i].timer?.invalidate()
                gameItemsArray[i].timer = nil
                gameItemsArray[i].yOffset = CGFloat.random(in: -0.8 ... -0.7)
                gameItemsArray[i].xOffset = xOffsetsArray.randomElement()!
                gameItemsArray[i].dropTime = CGFloat.random(in: 0.02...0.04)
                gameItemsArray[i].timer = Timer.scheduledTimer(withTimeInterval: gameItemsArray[i].dropTime, repeats: true) { _ in
                    withAnimation() {
                        gameItemsArray[i].yOffset += 0.01
                    }
                }
            }
        }
    }
    
    func dropCoinAnimation() {
        let xOffsetsArray = [-0.3, -0.2, -0.1, 0, 0.1, 0.2, 0.3]
        dropCoin.timer?.invalidate()
        dropCoin.timer = nil
        dropCoin.yOffset = CGFloat.random(in: -0.8 ... -0.7)
        dropCoin.xOffset = xOffsetsArray.randomElement()!
        dropCoin.dropTime = CGFloat.random(in: 0.01...0.02)
        dropCoin.timer = Timer.scheduledTimer(withTimeInterval: dropCoin.dropTime, repeats: true) { _ in
            withAnimation() {
                dropCoin.yOffset += 0.01
            }
        }
    }
    
    func dropWreathAnimation() {
        let xOffsetsArray = [-0.3, -0.2, -0.1, 0, 0.1, 0.2, 0.3]
        dropWreath.timer?.invalidate()
        dropWreath.timer = nil
        dropWreath.yOffset = CGFloat.random(in: -0.8 ... -0.7)
        dropWreath.xOffset = xOffsetsArray.randomElement()!
        dropWreath.dropTime = CGFloat.random(in: 0.01...0.02)
        dropWreath.timer = Timer.scheduledTimer(withTimeInterval: dropWreath.dropTime, repeats: true) { _ in
            withAnimation() {
                dropWreath.yOffset += 0.01
            }
        }
    }
    
    func moveKingLeft() {
        if kingXOffset > -0.3 {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                kingXOffset -= 0.1
                kingXOffset = (kingXOffset * 10).rounded() / 10
            }
            withAnimation(Animation.easeInOut(duration: 0.2)) {
                kingYOffset += 0.015
                kingRotation += 7
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(Animation.easeInOut(duration: 0.2)) {
                    kingYOffset -= 0.015
                    kingRotation -= 7
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print(kingXOffset)
            }
        }
    }
    
    func moveKingRight() {
        if kingXOffset < 0.3 {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                kingXOffset += 0.1
                kingXOffset = (kingXOffset * 10).rounded() / 10
            }
            withAnimation(Animation.easeInOut(duration: 0.2)) {
                kingYOffset += 0.015
                kingRotation -= 7
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(Animation.easeInOut(duration: 0.2)) {
                    kingYOffset -= 0.015
                    kingRotation += 7
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print(kingXOffset)
            }
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
    
    func startCheckTimer() {
        checkTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            for i in 0..<gameItemsArray.count {
                if gameItemsArray[i].yOffset > 0.25 &&
                    gameItemsArray[i].yOffset < 0.55 &&
                    gameItemsArray[i].xOffset == kingXOffset &&
                    !gameItemsArray[i].collected {
                    coinCount -= 1
                    gameItemsArray[i].opacity = 0
                    gameItemsArray[i].collected = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        gameItemsArray[i].collected = false
                        gameItemsArray[i].opacity = 1
                    }
                }
            }
            if dropCoin.yOffset > 0.25 &&
                dropCoin.yOffset < 0.55 &&
                dropCoin.xOffset == kingXOffset &&
                !dropCoin.collected {
                coinCount += 1
                dropCoin.opacity = 0
                dropCoin.collected = true
                SoundManager.instance.loopSound(sound: "soundCoin1")
                if achievementsData[0] == 0 {
                    achievementsData[0] = 1
                    UserDefaults.standard.setValue(achievementsData, forKey: "achievementsData")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    dropCoin.collected = false
                    dropCoin.opacity = 1
                }
            }
            if dropWreath.yOffset > 0.25 &&
                dropWreath.yOffset < 0.55 &&
                dropWreath.xOffset == kingXOffset &&
                !dropWreath.collected {
                stopTimer()
                stopCoinTimer()
                stopWreathTimer()
                closeMenuAnimation()
                SoundManager.instance.loopSound(sound: "soundCoin")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    coordinator.navigate(to: .bonusGame)
                }
                dropWreath.opacity = 0
                dropWreath.collected = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    dropWreath.collected = false
                    dropWreath.opacity = 1
                }
            }
        }
    }
    
    func startCoinTimer() {
        if coinTimer == nil {
            coinTimer = Timer.scheduledTimer(withTimeInterval: 7, repeats: true) { _ in
                dropCoinAnimation()
            }
        }
    }
    
    func stopCoinTimer() {
        coinTimer?.invalidate()
        coinTimer = nil
    }
    
    func startWreathTimer() {
        wreathTimer = Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { _ in
            dropWreathAnimation()
        }
    }
    
    func stopWreathTimer() {
        wreathTimer?.invalidate()
        wreathTimer = nil
    }
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { _ in
                dropItems()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}

#Preview {
    Game()
}
