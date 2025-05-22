//
//  Shop.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 20.05.2025.
//

import SwiftUI

struct Shop: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("wreathCount") var wreathCount = 0
    @AppStorage("shopType") var shopType = 1
    @State private var darckOpacity: CGFloat = 0
    @State private var shopArray = Arrays.backgroundArray
    @State private var shopItemsData = UserDefaults.standard.array(forKey: "shopItemsBGData") as? [Int] ?? [1,0,0,0,0]
    @State private var dataName = "shopItemsBGData"
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
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
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            coordinator.navigate(to: .selectShopItem)
                        }
                    }
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        .opacity(darckOpacity)
            HStack {
                ForEach(0..<shopArray.count, id: \.self) { item in
                    VStack {
                        Image(shopArray[item].name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.15)
                        Image("shopItemCost")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.12)
                            .overlay(
                                Text("\(shopArray[item].cost)")
                                    .font(Font.custom("Jomhuria-Regular", size: screenWidth*0.05))
                                    .foregroundColor(Color("textColor"))
                                    .offset(x: screenWidth*0.01, y: screenWidth*0.004)
                            )
                        if coinCount >= shopArray[item].cost || shopItemsData[item] == 1{
                            if shopItemsData[item] == 0 {
                                Image("shopMarkPlus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.06)
                                    .onTapGesture {
                                        buyItem(item: item)
                                    }
                            }
                            if shopItemsData[item] == 1 {
                                Image("shopMarkOk")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.06)
                            }
                        } else {
                            Image("shopMarkLock")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.06)
                        }
                    }
                }
            }
            .offset(y: screenWidth*0.05)
            .opacity(darckOpacity)
        }
       
        .onAppear {
            updateShopArray()
            showMenuAnimation()
        }
        
    }
    
    func buyItem(item: Int) {
        if coinCount >= shopArray[item].cost {
            coinCount -= shopArray[item].cost
            shopItemsData[item] = 1
            UserDefaults.standard.set(shopItemsData, forKey: dataName)
        }
    }
    
    func updateShopArray() {
        switch shopType {
        case 1:
            shopArray = Arrays.backgroundArray
            dataName = "shopItemsBGData"
            shopItemsData = UserDefaults.standard.array(forKey: "shopItemsBGData") as? [Int] ?? [1,0,0,0,0]
        default:
            shopArray = Arrays.wreathArray
            dataName = "shopItemsWreathData"
            shopItemsData = UserDefaults.standard.array(forKey: "shopItemsWreathData") as? [Int] ?? [1,0,0,0,0]
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
    Shop()
}
