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
    
    let appearedID = PassthroughSubject<Int?, PunkNetworkError>()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(model: BeerListModel = BeerListModel()) {
        let loadBeerList = appearedID
            .map { model.getPageToPatch(beers: self.beers, id: $0) }
            .filter { $0 != nil }
            .eraseToAnyPublisher()
        
        loadBeerList
            .prepend(nil)
            .flatMap(model.getBeerList)
            .receive(on: DispatchQueue.main)

            .sink(
                receiveCompletion: {
                    guard case .failure = $0 else { return }
                    self.beers = []
                },
                receiveValue:  { beers in
                    self.beers += beers
                }
            )
            .store(in: &cancellables)
    }
}
