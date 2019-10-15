//
//  MainView.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/15.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import SwiftUI
import Combine

struct MainView: View {
    @ObservedObject var beerListViewModel: BeerListViewModel
    
    init(beerListViewModel: BeerListViewModel) {
        self.beerListViewModel = beerListViewModel
    }
    
    var body: some View {
        TabView {
            BeerList(viewModel: beerListViewModel)
                .tabItem {
                    Text("맥주리스트")
            }
        }
    }
}
