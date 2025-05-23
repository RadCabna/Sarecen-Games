//
//  MiniGame2.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 22.05.2025.
//

import SwiftUI

struct MiniGame2: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var darckOpacity: CGFloat = 0
    @State private var timer: Timer? = nil
    @State private var elapsedTime = 45
    @State private var yourLife = [0,0,0,0,0]
    @State private var cardsArray1 = Arrays.cardsArray
    @State private var cardsArray2 = Arrays.cardsArray
    @State private var closeCardsArray: [Cards] = Array(repeating: Cards(name: ""), count: 12)
    @State private var chosenCards: [String] = []
    @State private var chosenCardsIndexArray: [Int] = []
    @State private var tapCount = 0
    @State private var stepNumber = 0
    @State private var firstIndex = 0
    @State private var secondIndex = 0
    @State private var pairsCount = 0
    @State private var youLose = false
    @State private var youWin = false
    var body: some View {
        ZStack {
            Background(backgroundNumber: 2)
            ZStack {
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
                    .padding(.bottom)
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
            VStack(spacing: screenWidth*0.01) {
                Text("MATCH THE CARDS")
                    .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.07))
                    .foregroundColor(Color("textColor"))
                    .shadow(color:.black, radius: 3, x: 2, y: 3)
                HStack {
                    ForEach(0..<yourLife.count, id: \.self) { item in
                        Image(yourLife[item] == 0 ? "fullHeart" : "emptyHeart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.06)
                    }
                }
                .padding(.bottom)
                HStack {
                    ForEach(0..<6, id: \.self) { item in
                        Image(closeCardsArray[item].open ? closeCardsArray[item].name : "closeCard")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.12)
                            .onTapGesture {
                                tapOnCard(item: item)
                            }
                    }
                }
                HStack {
                    ForEach(6..<12, id: \.self) { item in
                        Image(closeCardsArray[item].open ? closeCardsArray[item].name : "closeCard")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.12)
                            .onTapGesture {
                                tapOnCard(item: item)
                            }
                    }
                }
            }
            .opacity(darckOpacity)
            .offset(y: screenWidth*0.05)
            
            if youWin {
                WinMiniGame(youWin: $youWin)
            }
            if youLose {
                LoseMiniGame(youLose: $youLose)
            }
        }
        
        .onChange(of: stepNumber) { _ in
            if stepNumber == 5 {
                stopTimer()
                youLose = true
            }
        }
        
        .onChange(of: elapsedTime) { _ in
            if elapsedTime <= 0 {
                stopTimer()
                youLose = true
            }
        }
        
        .onChange(of: pairsCount) { _ in
            if pairsCount == 6 {
                stopTimer()
                youWin = true
            }
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
        
        .onAppear {
            shuffleCards()
            showMenuAnimation()
            startTimer()
        }
        
    }
    
    func restartGame() {
        yourLife = [0,0,0,0,0]
        cardsArray1 = Arrays.cardsArray
        cardsArray2 = Arrays.cardsArray
        closeCardsArray = cardsArray1.shuffled() + cardsArray2.shuffled()
        closeCardsArray = closeCardsArray.shuffled()
        chosenCards = []
        chosenCardsIndexArray = []
        elapsedTime = 45
        stepNumber = 0
        pairsCount = 0
        startTimer()
    }
    
    func shuffleCards() {
        closeCardsArray = cardsArray1.shuffled() + cardsArray2.shuffled()
        closeCardsArray = closeCardsArray.shuffled()
    }
    
    func tapOnCard(item: Int) {
        if !closeCardsArray[item].open {
            withAnimation() {
                closeCardsArray[item].open = true
            }
            chosenCards.append(closeCardsArray[item].name)
            chosenCardsIndexArray.append(item)
        }
        if chosenCardsIndexArray.count == 2 {
            checkYourCards()
        }
    }
    
    func checkYourCards() {
        if chosenCards[0] != chosenCards[1] {
            yourLife[4 - stepNumber] = 1
            stepNumber += 1
            for i in 0..<closeCardsArray.count {
                if closeCardsArray[i].open && !closeCardsArray[i].correct {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation() {
                            closeCardsArray[i].open = false
                        }
                    }
                }
            }
        } else {
            closeCardsArray[chosenCardsIndexArray[0]].correct = true
            closeCardsArray[chosenCardsIndexArray[1]].correct = true
            pairsCount += 1
        }
        chosenCards.removeAll()
        chosenCardsIndexArray.removeAll()
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
    MiniGame2()
}
