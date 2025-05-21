//
//  Model.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 20.05.2025.
//

import Foundation

struct ShopItem {
    var name: String
    var cost: Int
}

struct CastleImage {
    var image: String
    var name:String
    var text: String
    var yOffset: CGFloat
}

struct CastleUpgrade {
    var incCoin: Int
    var incWreth: Int
    var costCoin: Int
    var costWreth: Int
}

struct PuzzleImages: Equatable {
    
    var imageName: String
    var indexOfImage: Int
    var rotation:CGFloat = 0
    var offset:CGSize
    var startOffset:CGSize? = nil
}


class Arrays {
    
    static var puzzlePartsArray = [
        ["mosaic10","mosaic11","mosaic12","mosaic13","mosaic14","mosaic15","mosaic16","mosaic17","mosaic18"],
        ["mosaic20","mosaic21","mosaic22","mosaic23","mosaic24","mosaic25","mosaic26","mosaic27","mosaic28"],
        ["mosaic30","mosaic31","mosaic32","mosaic33","mosaic34","mosaic35","mosaic36","mosaic37","mosaic38"],
        ["mosaic40","mosaic41","mosaic42","mosaic43","mosaic44","mosaic45","mosaic46","mosaic47","mosaic48"],
        ["mosaic50","mosaic51","mosaic52","mosaic53","mosaic54","mosaic55","mosaic56","mosaic57","mosaic58"],
    ]
    
    static var puzzle1: [PuzzleImages] = [
        PuzzleImages(imageName: "mosaic10", indexOfImage: 1, offset: CGSize(width: -104.6, height: -60)),
        PuzzleImages(imageName: "mosaic11", indexOfImage: 2, offset: CGSize(width: 0, height: -60)),
        PuzzleImages(imageName: "mosaic12", indexOfImage: 3, offset: CGSize(width: 104.6, height:  -60)),
        PuzzleImages(imageName: "mosaic13", indexOfImage: 4, offset: CGSize(width: -104.6, height: 44.16)),
        PuzzleImages(imageName: "mosaic14", indexOfImage: 5, offset: CGSize(width: 0, height:  44.16)),
        PuzzleImages(imageName: "mosaic15", indexOfImage: 6, offset: CGSize(width: 104.6, height: 44.16)),
        PuzzleImages(imageName: "mosaic16", indexOfImage: 7, offset: CGSize(width: -104.6, height: 148.8)),
        PuzzleImages(imageName: "mosaic17", indexOfImage: 8, offset: CGSize(width: 0, height: 148.8)),
        PuzzleImages(imageName: "mosaic18", indexOfImage: 9, offset: CGSize(width: 104.6, height: 148.8)),
    ]
    
    static var snapPointsPuzzleTen: [CGSize] = [
        CGSize(width: -104.6, height: -60),
        CGSize(width: 0, height: -60),
        CGSize(width: 104.6, height:  -60),
        CGSize(width: -104.6, height: 44.16),
        CGSize(width: 0, height:  44.16),
        CGSize(width: 104.6, height: 44.16),
        CGSize(width: -104.6, height: 148.8),
        CGSize(width: 0, height: 148.8),
        CGSize(width: 104.6, height: 148.8),
       ]
    
    static var castleUpgradeInfo: [CastleUpgrade] = [
        CastleUpgrade(incCoin: 10, incWreth: 5, costCoin: 3, costWreth: 1),
        CastleUpgrade(incCoin: 30, incWreth: 15, costCoin: 7, costWreth: 2),
        CastleUpgrade(incCoin: 60, incWreth: 30, costCoin: 12, costWreth: 3),
        CastleUpgrade(incCoin: 120, incWreth: 60, costCoin: 20, costWreth: 5),
        CastleUpgrade(incCoin: 250, incWreth: 100, costCoin: 30, costWreth: 7)
        ]
    
    static var castleArray: [CastleImage] = [
        CastleImage(image: "castle1", name: "King’s Keep", text: "A grand fortress tower where the ruler oversees the kingdom. Upgrading the keep enhances control, unlocking new features and expanding your influence.", yOffset: 0),
        CastleImage(image: "castle2", name: "Royal Barracks", text: "The training ground for the king’s army. Upgrading increases defense and speeds up the recruitment of knights.", yOffset: 0.2),
        CastleImage(image: "castle3", name: "Temple of Light", text: "A sacred place devoted to divine powers. Upgrading grants blessings and brings spiritual prosperity.", yOffset: 0),
        CastleImage(image: "castle4", name: "Grand Arena", text: "A massive arena where knights fight for honor and glory. Upgrading draws more spectators and increases revenue.", yOffset: 0.2),
        CastleImage(image: "castle5", name: "Healing Springs", text: "Restorative baths where citizens rejuvenate. Upgrading improves wellbeing and lowers health-related costs.", yOffset: 0),
    ]
    
    static var backgroundArray: [ShopItem] = [
        ShopItem(name: "shopBG1", cost: 0),
        ShopItem(name: "shopBG2", cost: 100),
        ShopItem(name: "shopBG3", cost: 300),
        ShopItem(name: "shopBG4", cost: 500),
        ShopItem(name: "shopBG5", cost: 900),
    ]
    
    static var wreathArray: [ShopItem] = [
        ShopItem(name: "shopWreath1", cost: 0),
        ShopItem(name: "shopWreath2", cost: 100),
        ShopItem(name: "shopWreath3", cost: 300),
        ShopItem(name: "shopWreath4", cost: 500),
        ShopItem(name: "shopWreath5", cost: 900),
    ]
}
