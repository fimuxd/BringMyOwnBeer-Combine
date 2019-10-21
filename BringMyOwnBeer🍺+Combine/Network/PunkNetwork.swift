//
//  PunkNetwork.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/14.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import Foundation
import Combine

enum PunkNetworkError: Error {
    case error(String)
    case defaultError
    
    var message: String? {
        switch self {
        case let .error(msg):
            return msg
        case .defaultError:
            return "잠시 후에 다시 시도해주세요."
        }
    }
}

protocol PunkNetwork {
    func getBeers(page: Int?) -> AnyPublisher<[Beer], PunkNetworkError>
    func getBeer(id: String) -> AnyPublisher<[Beer], PunkNetworkError>
    func getRandomBeer() -> AnyPublisher<[Beer], PunkNetworkError>
}
