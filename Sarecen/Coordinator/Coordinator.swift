//
//  Coordinator.swift
//  Sarecen
//
//  Created by Алкександр Степанов on 20.05.2025.
//

import Foundation
import SwiftUI

enum CoordinatorView: Equatable {
    case loading
    case mainMenu
    case settings
    case game
    case choseGame
    case selectShopItem
   case shop
    case castle
}

final class Coordinator: ObservableObject {
    @Published var path: [CoordinatorView] = []

    func resolve(pathItem: CoordinatorView) -> AnyView {
        var view = AnyView(Loading())
        switch pathItem {
        case .loading:
            view = AnyView(Loading())
        case .mainMenu:
            view = AnyView(Menu())
        case .game:
            view = AnyView(Game())
        case .settings:
            view = AnyView(Settings())
        case .choseGame:
            view = AnyView(ChoseGame())
        case .selectShopItem:
            view = AnyView(SelectShopItem())
        case .shop:
            view = AnyView(Shop())
        case .castle:
            view = AnyView(Castle())
        }
        return view
    }
    
    func navigate(to pathItem: CoordinatorView) {
        path.append(pathItem)
    }
    
    func navigateBack() {
        _ = path.popLast()
    }
}

struct ContentView: View {
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        ZStack {
            coordinator.resolve(pathItem: coordinator.path.last ?? .loading)
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    ContentView()
}




