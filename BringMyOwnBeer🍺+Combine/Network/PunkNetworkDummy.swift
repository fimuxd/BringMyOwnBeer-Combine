//
//  PunkNetworkDummy.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/20.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import Foundation
import Combine

class PunkNetworkDummy: PunkNetwork {
    func getBeers(page: Int?) -> AnyPublisher<[Beer], PunkNetworkError> {
        return Just(beersData)
            .mapError { error in
                .error("dummy data JSON parsing 에러")
            }
            .eraseToAnyPublisher()
    }
    
    func getBeer(id: String) -> AnyPublisher<[Beer], PunkNetworkError> {
        guard let id = Int(id) else {
            return Fail(error: PunkNetworkError.error("유효하지 않은 dummy data")).eraseToAnyPublisher()
        }
        return Just([beersData[id]])
            .mapError { error in
                .error("dummy data JSON parsing 에러")
            }
            .eraseToAnyPublisher()
    }
    
    func getRandomBeer() -> AnyPublisher<[Beer], PunkNetworkError> {
        let randomID = Int.random(in: 0...324)
        
        return Just([beersData[randomID]])
        .mapError { error in
            .error("dummy data JSON parsing 에러")
        }
        .eraseToAnyPublisher()
    }
}
