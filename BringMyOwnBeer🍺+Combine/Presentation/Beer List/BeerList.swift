//
//  BeerList.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/14.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import SwiftUI
import Combine

struct BeerList: View {
    @ObservedObject var viewModel: BeerListViewModel
    
    init(viewModel: BeerListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.beers, id: \.id) { beer in
                BeerRow(beer: beer).onAppear {
                    let lastRowCount = self.viewModel.beers.count
                    let lastIndex = self.viewModel.beers.firstIndex { $0.id == beer.id }
                    let page = lastRowCount / 75 + 1
                    
                    guard (74...325) ~= lastRowCount else {
                        return
                    }
                    
                    if lastRowCount - 1 == lastIndex {
                        self.viewModel.getBeers(page: page)
                    }
                }
            }
            .navigationBarTitle(Text("맥주리스트"))
        }
    }
}

struct BeerList_Previews: PreviewProvider {
    static var previews: some View {
        let dummyService = PunkNetworkDummy()
        let beerListViewModel = BeerListViewModel(punkService: dummyService)
        
        return ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            BeerList(viewModel: beerListViewModel)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
