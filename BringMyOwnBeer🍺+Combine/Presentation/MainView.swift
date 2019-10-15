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
    @ObservedObject var searchViewModel: SearchViewModel
    @ObservedObject var randomViewModel: RandomViewModel
    
    init(
        beerListViewModel: BeerListViewModel,
        searchViewModel: SearchViewModel,
        randomViewModel: RandomViewModel
    ) {
        self.beerListViewModel = beerListViewModel
        self.searchViewModel = searchViewModel
        self.randomViewModel = randomViewModel
    }
    
    var body: some View {
        TabView {
            BeerList(viewModel: beerListViewModel)
                .tabItem {
                    Image(uiImage: #imageLiteral(resourceName: "iconBeerList"))
                    Text("맥주리스트")
                }
            SearchView(viewModel: searchViewModel)
                .tabItem {
                    Image(uiImage: #imageLiteral(resourceName: "iconSearchID"))
                    Text("ID 검색")
                }
            RandomView(viewModel: randomViewModel)
                .tabItem {
                    Image(uiImage: #imageLiteral(resourceName: "iconRandom"))
                    Text("아무거나 검색")
                }
        }
    }
}
