//
//  MiniGame1.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 22.05.2025.
//

import SwiftUI

struct MiniGame1: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var darckOpacity: CGFloat = 0
    @State private var youLose = false
    @State private var youWin = false
    @State private var correctNumber = [4, 5, 6]
    @State private var yourNumber = [10, 10, 10]
    @State private var numberId = 0
    var body: some View {
        ZStack {
            Background(backgroundNumber: 5)
            ZStack {
                Text("GUES THE NUMBERS")
                    .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.07))
                    .foregroundColor(Color("textColor"))
                    .shadow(color:.black, radius: 3, x: 2, y: 3)

                HStack {
                    Image("restartButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.08)
                        .onTapGesture {
                            closeMenuAnimation()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                yourNumber = [10, 10, 10]
                                numberId = 0
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
                                coordinator.navigate(to: .selectMiniGames)
                            }
                        }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .opacity(darckOpacity)
            VStack(spacing: screenWidth*0.04) {
                HStack {
                    ForEach (0..<correctNumber.count, id:\.self) { id in
                        Image("circleNumber")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.16)
                            .overlay(
                                ZStack {
                                    if yourNumber[id] != 10 {
                                        Text("\(yourNumber[id])")
                                            .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.12))
                                            .foregroundColor(yourNumber[id] == correctNumber[id] ? .white : .red)
                                            .shadow(color:.black, radius: 3, x: 2, y: 3)
                                            .padding(.top)
                                    }
                                }
                            )
                    }
                }
                HStack {
                    ForEach (0..<10, id:\.self) { id in
                        Image("numberFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.07)
                            .overlay(
                                Text("\(id)")
                                    .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.07))
                                    .foregroundColor(Color("textColor"))
                                    .shadow(color:.black, radius: 3, x: 2, y: 3)
                                    .padding(.top, screenWidth*0.01)
                            )
                            .onTapGesture {
                                tapOnNumber(id: id)
                            }
                    }
                }
            }
            .opacity(darckOpacity)
            .offset(y: screenWidth*0.04)
            
            if youWin {
                WinMiniGame(youWin: $youWin)
            }
            if youLose {
                LoseMiniGame(youLose: $youLose)
            }
        }
        
        .onAppear {
            showMenuAnimation()
            randomeNumver()
        }
        
        .onChange(of: youLose) { _ in
            if !youLose {
                yourNumber = [10, 10, 10]
                numberId = 0
            }
        }
        
        .onChange(of: youWin) { _ in
            if !youWin {
                randomeNumver()
                yourNumber = [10, 10, 10]
                numberId = 0
            }
        }
        
        .onChange(of: numberId) { _ in
            if numberId == 3 {
               checkCorrect()
            }
        }
        
    }
    
    func randomeNumver() {
        for i in 0..<correctNumber.count {
            correctNumber[i] = Int.random(in: 0...9)
        }
    }
    
    func checkCorrect(){
       if correctNumber == yourNumber {
           DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
               youWin = true
           }
       } else {
           DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
               youLose = true
           }
       }
    }
    
    func tapOnNumber(id: Int) {
        if numberId < 3 {
            yourNumber[numberId] = id
            numberId += 1
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
    MiniGame1()
}
