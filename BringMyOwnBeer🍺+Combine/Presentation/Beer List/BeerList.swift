//
//  BeerList.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/14.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import SwiftUI

struct BeerList: View {
    @ObservedObject var viewModel: BeerListViewModel
    
    init(viewModel: BeerListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.beers, id: \.id) { beer in
                BeerRow(beer: beer).onAppear {
                    self.viewModel.appearedID.send(beer.id)
                }
            }
            .navigationBarTitle(Text("맥주리스트"))
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text(viewModel.errorMessage))
        }
    }
}

struct BeerList_Previews: PreviewProvider {
    static var previews: some View {
        let beerListViewModel = BeerListViewModel()
        
        return ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            BeerList(viewModel: beerListViewModel)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
