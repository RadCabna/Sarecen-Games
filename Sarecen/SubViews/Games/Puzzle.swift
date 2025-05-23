//
//  Puzzle.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 21.05.2025.
//

import SwiftUI

struct Puzzle: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var achievementsData = UserDefaults.standard.array(forKey: "achievementsData") as? [Int] ?? [0,0,0,0,0]
    @State private var levelNumber = 10
    @State private var timer: Timer? = nil
    @State private var elapsedTime = 150
    @State private var puzzleArray = Arrays.puzzle1
    @State private var correctPuzzleArray = Arrays.puzzle1
    @State private var snapPoints: [CGSize] = Arrays.snapPointsPuzzleTen
    @State private var puzzlePartsArray = Arrays.puzzlePartsArray
    @State private var partSize = 80.8
    @State private var makeShuffle = false
    @State private var darckOpacity: CGFloat = 0
    @State private var youLose = false
    @State private var youWin = false
    var body: some View {
        ZStack {
            Background(backgroundNumber: 6)
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
            Image("formRectangle")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.37)
                .offset(y: screenWidth*0.05)
                .opacity(darckOpacity)
            ForEach(puzzleArray.indices, id: \.self) { Index in
                Image(puzzleArray[Index].imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height:partSize)
                
                    .rotationEffect(Angle(degrees: puzzleArray[Index].rotation))
                    .offset(puzzleArray[Index].offset)
                    .onTapGesture {
                        //                        if sound {
                        //                            SoundPlayer.playSound(index: .random(in: 0...4))
                        //                        }
                        SoundManager.instance.loopSound(sound: "soundDragCard")
                        withAnimation(.easeIn(duration: 0.2)) {
                            puzzleArray[Index].rotation += 90
                        }
                        if  puzzleArray[Index].rotation == 360{
                            puzzleArray[Index].rotation = 0
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.spring()) {
                                    
                                    if let startOffset = puzzleArray[Index].startOffset {
                                        puzzleArray[Index].offset = CGSize(width: startOffset.width + value.translation.width, height: startOffset.height + value.translation.height)
                                    } else {
                                        puzzleArray[Index].startOffset = puzzleArray[Index].offset
                                    }
                                }
                            }
                            .onEnded { value in
                                SoundManager.instance.loopSound(sound: "soundMoveCard")
                                withAnimation(.spring()) {
                                    puzzleArray[Index].startOffset = nil
                                    whatPosition(Index: Index)
                                }
                            }
                    )
            }
            .opacity(darckOpacity)
            
            if youLose {
                LosePuzzle(youLose: $youLose)
            }
            
            if youWin {
                WinPuzzle(youWin: $youWin)
            }
            
        }
        
        .onChange(of: youWin) { _ in
            if !youWin {
                restartGame()
                updateYourPuzzle()
            }
        }
        
        .onChange(of: youLose) { _ in
            if !youLose {
                restartGame()
            }
        }
        
        .onChange(of: elapsedTime) { _ in
            if elapsedTime < 0 {
                stopTimer()
                youLose = true
            }
        }
        
        .onChange(of: puzzleArray) { _ in
            if puzzleArray == correctPuzzleArray && makeShuffle{
                stopTimer()
                youWin = true
                if achievementsData[1] == 0 {
                    achievementsData[1] = 1
                    UserDefaults.standard.setValue(achievementsData, forKey: "achievementsData")
                }
            }
        }
        
        .onAppear {
            updateYourPuzzle()
            startTimer()
            showMenuAnimation()
            partSize = screenWidth*0.12
            mixAllParts()
            updateOffsets()
        }
        
    }
    
    func restartGame() {
        makeShuffle = false
        stopTimer()
        elapsedTime = 150
        showStartPuzzleImage()
        updateOffsets()
        mixAllParts()
        startTimer()
    }
    
    func updateYourPuzzle() {
        if let randomePuzzle = puzzlePartsArray.randomElement() {
            for i in 0..<puzzleArray.count {
                puzzleArray[i].imageName = randomePuzzle[i]
                correctPuzzleArray[i].imageName = randomePuzzle[i]
            }
        }
    }
    
    func showStartPuzzleImage() {
        for i in 0..<puzzleArray.count {
            puzzleArray[i].rotation = correctPuzzleArray[i].rotation
            puzzleArray[i].offset = correctPuzzleArray[i].offset
        }
    }
    
    func updateOffsets() {
        for i in 0..<puzzleArray.count {
            puzzleArray[i].offset.width *= screenWidth/874
            puzzleArray[i].offset.height *= screenWidth/874
            correctPuzzleArray[i].offset.width *= screenWidth/874
            correctPuzzleArray[i].offset.height *= screenWidth/874
            snapPoints[i].width *= screenWidth/874
            snapPoints[i].height *= screenWidth/874
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
    
    func mixAllParts(){
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5){
            withAnimation(Animation.easeInOut(duration: 1.5)){
                for i in puzzleArray.indices {
                    puzzleArray[i].offset = CGSize(width: randomInRangeX(), height: randomInRangeY())
                }
                for i in puzzleArray.indices {
                    puzzleArray[i].rotation = randomRotation()
                }
            }
            makeShuffle = true
        }
    }
    
    func randomRotation() -> CGFloat{
        let degreeze: [CGFloat] = [90,180,270,0]
        let randomeIndex = Int.random(in: 0...degreeze.count-1)
        return degreeze[randomeIndex]
    }
    
    func randomInRangeX() -> CGFloat {
        return CGFloat.random(in: -200*screenWidth/874...250*screenWidth/874)
    }
    
    func randomInRangeY() -> CGFloat {
        return CGFloat.random(in: -100*screenWidth/874...150*screenWidth/874)
    }
    
    func whatPosition(Index: Int) {
        if levelNumber > 9 && levelNumber < 13 {
            //            if sound {
            //                SoundPlayer.playSound(index: .random(in: 0...4))
            //            }
            if (puzzleArray[Index].offset.width < -75*screenWidth/874 && puzzleArray[Index].offset.width > -135*screenWidth/874) && (puzzleArray[Index].offset.height < -30*screenWidth/874 && puzzleArray[Index].offset.height > -90*screenWidth/874) {
                puzzleArray[Index].offset = snapPoints[0]
            }
            if (puzzleArray[Index].offset.width < 30*screenWidth/874 && puzzleArray[Index].offset.width > -30*screenWidth/874) && (puzzleArray[Index].offset.height < -30*screenWidth/874 && puzzleArray[Index].offset.height > -90*screenWidth/874) {
                puzzleArray[Index].offset = snapPoints[1]
            }
            if (puzzleArray[Index].offset.width < 135*screenWidth/874 && puzzleArray[Index].offset.width > 75*screenWidth/874) && (puzzleArray[Index].offset.height < -30*screenWidth/874 && puzzleArray[Index].offset.height > -90*screenWidth/874) {
                puzzleArray[Index].offset = snapPoints[2]
            }
            if (puzzleArray[Index].offset.width < -75*screenWidth/874 && puzzleArray[Index].offset.width > -135*screenWidth/874) && (puzzleArray[Index].offset.height < 76*screenWidth/874 && puzzleArray[Index].offset.height > 15*screenWidth/874) {
                puzzleArray[Index].offset = snapPoints[3]
            }
            if (puzzleArray[Index].offset.width < 30*screenWidth/874 && puzzleArray[Index].offset.width > -30*screenWidth/874) && (puzzleArray[Index].offset.height < 76*screenWidth/874 && puzzleArray[Index].offset.height > 15*screenWidth/874) {
                puzzleArray[Index].offset = snapPoints[4]
            }
            if (puzzleArray[Index].offset.width < 135*screenWidth/874 && puzzleArray[Index].offset.width > 75*screenWidth/874) && (puzzleArray[Index].offset.height < 76*screenWidth/874 && puzzleArray[Index].offset.height > 15*screenWidth/874) {
                puzzleArray[Index].offset = snapPoints[5]
            }
            if (puzzleArray[Index].offset.width < -75*screenWidth/874 && puzzleArray[Index].offset.width > -135*screenWidth/874) && (puzzleArray[Index].offset.height < 180*screenWidth/874 && puzzleArray[Index].offset.height > 120*screenWidth/874) {
                puzzleArray[Index].offset = snapPoints[6]
            }
            if (puzzleArray[Index].offset.width < 30*screenWidth/874 && puzzleArray[Index].offset.width > -30*screenWidth/874) && (puzzleArray[Index].offset.height < 180*screenWidth/874 && puzzleArray[Index].offset.height > 120*screenWidth/874) {
                puzzleArray[Index].offset = snapPoints[7]
            }
            if (puzzleArray[Index].offset.width < 135*screenWidth/874 && puzzleArray[Index].offset.width > 75*screenWidth/874) && (puzzleArray[Index].offset.height < 180*screenWidth/874 && puzzleArray[Index].offset.height > 120*screenWidth/874) {
                puzzleArray[Index].offset = snapPoints[8]
            }
        }
    }
    
}

#Preview {
    Puzzle()
}
