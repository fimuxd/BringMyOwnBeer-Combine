//
//  BeerList+SwiftUI.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/14.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import SwiftUI

struct BeerList: View {
    @ObservedObject var viewModel: BeerListViewModelWithCombine
    
    init(viewModel: BeerListViewModelWithCombine) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.beers) { beer in
                BeerRow(beer: beer)
            }
        }
        .navigationBarTitle("맥주리스트")
    }
}
