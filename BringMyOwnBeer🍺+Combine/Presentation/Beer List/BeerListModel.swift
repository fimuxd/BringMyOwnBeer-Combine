//
//  BeerListModel.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/30.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import Foundation
import Combine

struct BeerListModel {
    let punkNetwork: PunkNetwork
    
    init(punkNetwork: PunkNetwork = PunkNetworkImpl()) {
        self.punkNetwork = punkNetwork
    }
    
    func getBeerList(page: Int?) -> AnyPublisher<[Beer], PunkNetworkError> {
        return punkNetwork.getBeers(page: page)
    }
    
    func getPageToPatch(beers: [Beer], id: Int?) -> Int? {
        let lastRowCount = beers.count
        let lastIndex = beers.firstIndex { id == $0.id }
        let page = lastRowCount / 75 + 1

        guard (74...325) ~= lastRowCount,
            lastRowCount - 1 == lastIndex else {
            return nil
        }
        
        return page
    }

}
