//
//  SceneDelegate.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/14.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let punkNetwork = PunkNetworkImpl()
        
        let beerListViewModel = BeerListViewModel()
        let searchViewModel = SearchViewModel(punkService: punkNetwork)
        let randomViewModel = RandomViewModel(punkService: punkNetwork)
        
        let mainView = MainView(
            beerListViewModel: beerListViewModel,
            searchViewModel: searchViewModel,
            randomViewModel: randomViewModel
        )

        // Use a UIHostingController as window root view controller
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: mainView)
        window.makeKeyAndVisible()
        self.window = window
    }
}
