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
    
    init(
        beerListViewModel: BeerListViewModel,
        searchViewModel: SearchViewModel
    ) {
        self.beerListViewModel = beerListViewModel
        self.searchViewModel = searchViewModel
    }
    
    var body: some View {
        TabView {
            BeerList(viewModel: beerListViewModel)
                .tabItem { Text("맥주리스트") }
            SearchView(viewModel: searchViewModel)
                .tabItem { Text("ID검색") }
        }
    }
}
