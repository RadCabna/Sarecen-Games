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

class Arrays {
    
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
