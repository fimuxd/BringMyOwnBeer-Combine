//
//  RandomViewModel.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/15.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import Combine
import SwiftUI

class RandomViewModel: ObservableObject {
    @Published var beer: Beer? = nil
 
    private let punkNetwork: PunkNetwork
    private var cancellables = Set<AnyCancellable>()
    
    init(
        punkService: PunkNetwork,
        scheduler: DispatchQueue = DispatchQueue(label: "RandomViewModel")
    ) {
        self.punkNetwork = punkService
    }
    
    func getRandomBeer() {
        punkNetwork.getRandomBeer()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else {
                        return
                    }
                    switch value {
                    case .failure:
                        self.beer = nil
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] beers in
                    guard let self = self else {
                        return
                    }
                    self.beer = beers.first
                }
            )
            .store(in: &cancellables)    // &= 메모리 참조
    }
}

