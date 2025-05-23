//
//  MiniGame3.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 22.05.2025.
//

import SwiftUI

struct MiniGame3: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var darckOpacity: CGFloat = 0
    @State private var stepNumber = 0
    @State private var cardsArray = Arrays.cardsArray
    @State private var correctCardsArray: [String] = ["eptyCardFrame"]
    @State private var shuffledCardArray: [String] = ["eptyCardFrame"]
    @State private var yourCardsArray: [String] = ["eptyCardFrame","eptyCardFrame","eptyCardFrame","eptyCardFrame","eptyCardFrame","eptyCardFrame"]
    @State private var cardLogoArray = Arrays.cardLogoArray
    @State private var showCardIndex = 0
    @State private var showCardOpacity: CGFloat = 0
    @State private var gameOpacity: CGFloat = 0
    @State private var startButtonOpacity: CGFloat = 1
    @State private var youLose = false
    @State private var youWin = false
    @State private var canStep = true
    var body: some View {
        ZStack {
            Background(backgroundNumber: 2)
            ZStack {
                HStack {
                    Image("restartButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.08)
                        .onTapGesture {
                            //                            restartGame()
                            closeMenuAnimation()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                restartGame()
                                showMenuAnimation()
                            }
                        }
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
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .opacity(darckOpacity)
            ZStack {
                VStack {
                    HStack {
                        ForEach(0..<3, id: \.self) { item in
                            ZStack {
                                Image("emptyRect")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.1)
                                if yourCardsArray[item] != "eptyCardFrame" {
                                    Image(yourCardsArray[item])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.06)
                                }
                            }
                        }
                    }
                    HStack {
                        ForEach(3..<6, id: \.self) { item in
                            ZStack {
                                Image("emptyRect")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.1)
                                if yourCardsArray[item] != "eptyCardFrame" {
                                    Image(yourCardsArray[item])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.06)
                                }
                            }
                        }
                    }
                    HStack {
                        ForEach(0..<cardLogoArray.count, id:\.self) { item in
                            Image("eptyCardFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.12)
                                .overlay(
                                    Image(cardLogoArray[item])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.05)
                                )
                                .onTapGesture {
                                    if stepNumber < 6 {
                                        tapOnCard(item: item)
                                    }
                                }
                        }
                    }
                }
                .opacity(gameOpacity)
                ZStack {
                    Image("eptyCardFrame")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.23)
                    Image(correctCardsArray[showCardIndex])
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.12)
                }
                    .opacity(showCardOpacity)
                MenuButton(size: 0.35, text: "START")
                    .opacity(startButtonOpacity)
                    .onTapGesture {
                        startGameAnimation()
                    }
            }
            
            if youWin {
                WinMiniGame(youWin: $youWin)
            }
            if youLose {
                LoseMiniGame(youLose: $youLose)
            }
        }
        
        .onAppear {
            showMenuAnimation()
            shuffleCards()
        }
        
        .onChange(of: youWin) { _ in
            if !youWin {
               restartGame()
            }
        }
        
        .onChange(of: youLose) { _ in
            if !youLose {
               restartGame()
            }
        }
        
        .onChange(of: stepNumber) { _ in
            if stepNumber == 6 {
                if yourCardsArray == correctCardsArray {
                    youWin = true
                    print(yourCardsArray)
                    print(correctCardsArray)
                } else {
                    youLose = true
                    print(yourCardsArray)
                    print(correctCardsArray)
                }
            }
        }
        
    }
    
    func restartGame() {
        stepNumber = 0
        shuffleCards()
        yourCardsArray = ["","","","","",""]
        showCardIndex = 0
        startButtonOpacity = 1
        gameOpacity = 0
        showCardOpacity = 0
//        startGameAnimation()
    }
    
    func tapOnCard(item: Int) {
        yourCardsArray[stepNumber] = cardLogoArray[item]
        stepNumber += 1
    }
    
    func startGameAnimation() {
        withAnimation(Animation.easeInOut(duration: 1)) {
            startButtonOpacity = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showCardsAnimation()
        }
    }
    
    func showCardsAnimation() {
        var delay: Double = 0.5
        for _ in 0..<correctCardsArray.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    showCardOpacity = 1
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + delay + 0.5) {
                if showCardIndex < correctCardsArray.count - 1 {
                    showCardIndex += 1
                }
            }
            delay += 0.5
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                showCardOpacity = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                gameOpacity = 1
            }
        }
    }
    
    func shuffleCards() {
        correctCardsArray = []
        correctCardsArray = cardLogoArray.shuffled()
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
    MiniGame3()
}
