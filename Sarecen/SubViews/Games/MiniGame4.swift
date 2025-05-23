//
//  MiniGame4.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 22.05.2025.
//

import SwiftUI

struct MiniGame4: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var darckOpacity: CGFloat = 0
    @State private var timer: Timer? = nil
    @State private var elapsedTime = 60
    @State private var youLose = false
    @State private var youWin = false
    @State private var labyrinthArray = Arrays.labyrinthArray
    @State private var posibleStepsArray = Arrays.posibleStepsArray
    var body: some View {
        ZStack {
            Background(backgroundNumber: 2)
            HStack {
                Image("restartButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.08)
                    .onTapGesture {
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
                            coordinator.navigate(to: .selectMiniGames)
                        }
                    }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .opacity(darckOpacity)
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
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding()
                .opacity(darckOpacity)
            ZStack {
                Image("labirinthFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.4)
                VStack(spacing: screenWidth*0.0095) {
                    ForEach(0..<labyrinthArray.count, id: \.self) { row in
                        HStack(spacing: screenWidth*0.0085) {
                            ForEach(0..<labyrinthArray[row].count, id: \.self) { col in
                                ZStack {
                                    Image("star")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.022)
                                        .opacity(labyrinthArray[row][col].star ? 1 : 0)
                                    Image("heart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.022)
                                        .opacity(labyrinthArray[row][col].heart ? 1 : 0)
                                }
                            }
                        }
                    }
                }
            }
            .offset(y: screenWidth*0.01)
            .opacity(darckOpacity)
            VStack {
                Image("arrowUp")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.06)
                    .onTapGesture {
                        stepUp()
                    }
                HStack(spacing: screenWidth*0.06) {
                    Image("arrowLeft")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.06)
                        .onTapGesture {
                            stepLeft()
                        }
                    Image("arrowLeft")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.06)
                        .scaleEffect(x: -1)
                        .onTapGesture {
                            stepRight()
                        }
                }
                Image("arrowUp")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.06)
                    .scaleEffect(y: -1)
                    .onTapGesture {
                        stepDown()
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding()
            .opacity(darckOpacity)
            
            if youWin {
                WinMiniGame(youWin: $youWin)
            }
            if youLose {
                LoseMiniGame(youLose: $youLose)
            }
        }
        
        .onChange(of: youLose) { _ in
            if !youLose {
                restartGame()
            }
        }
        
        .onChange(of: youWin) { _ in
            if !youWin {
                restartGame()
            }
        }
        
        .onChange(of: elapsedTime) { _ in
            if elapsedTime <= 0 {
                stopTimer()
                youLose = true
            }
        }
        
        .onChange(of: labyrinthArray) { _ in
            if labyrinthArray[3][10].star {
                stopTimer()
                youWin = true
            }
        }
        
        .onAppear {
            showMenuAnimation()
            updateArraysPosibleSteps()
            startTimer()
        }
        
    }
    
    func restartGame() {
        stopTimer()
        elapsedTime = 60
        labyrinthArray = Arrays.labyrinthArray
        updateArraysPosibleSteps()
        startTimer()
    }
    
    func updateArraysPosibleSteps() {
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                let posibleStepsData = String(posibleStepsArray[i][j].code).compactMap { $0.wholeNumberValue }
                print(posibleStepsData)
                if posibleStepsData[0] == 1 {
                    labyrinthArray[i][j].left = true
                } else {
                    labyrinthArray[i][j].left = false
                }
                if posibleStepsData[1] == 1 {
                    labyrinthArray[i][j].right = true
                } else {
                    labyrinthArray[i][j].right = false
                }
                if posibleStepsData[2] == 1 {
                    labyrinthArray[i][j].up = true
                } else {
                    labyrinthArray[i][j].up = false
                }
                if posibleStepsData[3] == 1 {
                    labyrinthArray[i][j].down = true
                } else {
                    labyrinthArray[i][j].down = false
                }
            }
        }
    }
    
    func stepLeft() {
        var row = 0
        var col = 0
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                if labyrinthArray[i][j].star {
                    row = i
                    col = j
                }
            }
        }
        if labyrinthArray[row][col].left {
            labyrinthArray[row][col].star = false
            withAnimation() {
                labyrinthArray[row][col-1].star = true
            }
        }
    }
    
    func stepRight() {
        var row = 0
        var col = 0
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                if labyrinthArray[i][j].star {
                    row = i
                    col = j
                }
            }
        }
        if labyrinthArray[row][col].right {
            labyrinthArray[row][col].star = false
            withAnimation() {
                labyrinthArray[row][col+1].star = true
            }
        }
    }
    
    func stepDown() {
        var row = 0
        var col = 0
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                if labyrinthArray[i][j].star {
                    row = i
                    col = j
                }
            }
        }
        if labyrinthArray[row][col].down {
            labyrinthArray[row][col].star = false
            withAnimation() {
                labyrinthArray[row+1][col].star = true
            }
        }
    }
    
    func stepUp() {
        var row = 0
        var col = 0
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                if labyrinthArray[i][j].star {
                    row = i
                    col = j
                }
            }
        }
        if labyrinthArray[row][col].up {
            labyrinthArray[row][col].star = false
            withAnimation() {
                labyrinthArray[row-1][col].star = true
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
    
}

#Preview {
    MiniGame4()
}
