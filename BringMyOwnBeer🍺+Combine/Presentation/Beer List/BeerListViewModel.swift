//
//  BeerListViewModel.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/14.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import Combine
import SwiftUI

class BeerListViewModel: ObservableObject {
    @Published var beers: [Beer] = []
    
    private let punkNetwork: PunkNetwork
    private var disposables = Set<AnyCancellable>()
    
    init(
        punkService: PunkNetwork,
        scheduler: DispatchQueue = DispatchQueue(label: "BeerListViewModel")
    ) {
        self.punkNetwork = punkService
        _ = Just(Void())
            .sink(receiveValue: getBeers)
    }
    
    func getBeers() {
        punkNetwork.getBeers()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else {
                        return
                    }
                    switch value {
                    case .failure:
                        self.beers = []
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] beers in
                    guard let self = self else {
                        return
                    }
                    self.beers = beers
                }
            )
            .store(in: &disposables)
    }
}
