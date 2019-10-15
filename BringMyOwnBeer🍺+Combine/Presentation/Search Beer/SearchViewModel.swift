//
//  SearchViewModel.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/15.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import Combine
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var beer: Beer? = nil
    @Published var id: String = ""
    
    private let punkService: PunkService
    private var disposables = Set<AnyCancellable>()
    
    init(
        punkService: PunkService,
        scheduler: DispatchQueue = DispatchQueue(label: "SearchViewModel")
    ) {
        self.punkService = punkService
        _ = $id
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: getBeer(id:))
    }
    
    func getBeer(id: String) {
        punkService.getBeer(id: id)
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
            .store(in: &disposables)
    }
}
