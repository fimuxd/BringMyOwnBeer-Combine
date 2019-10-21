//
//  PunkServiceImpl.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/20.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import Foundation
import Combine

class PunkNetworkImpl: PunkNetwork {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getBeers(page: Int?) -> AnyPublisher<[Beer], PunkNetworkError> {
        guard let url = makeGetBeersComponents(page: page).url else {
            let error = PunkNetworkError.error("유효하지 않은 URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                PunkNetworkError.error("getBeers API 에러")
            }
            .flatMap(maxPublishers: .max(1)) { data in
                decode(data.data)
            }
            .eraseToAnyPublisher()
    }
    
    func getBeer(id: String) -> AnyPublisher<[Beer], PunkNetworkError> {
        guard let url = makeGetBeerComponents(id: id).url else {
            let error = PunkNetworkError.error("유효하지 않은 URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                PunkNetworkError.error("getBeer API 에러")
            }
            .flatMap(maxPublishers: .max(1)) { data in
                decode(data.data)
            }
            .eraseToAnyPublisher()
    }
    
    func getRandomBeer() -> AnyPublisher<[Beer], PunkNetworkError> {
        guard let url = makeGetRandomBeerComponents().url else {
            let error = PunkNetworkError.error("유효하지 않은 URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                PunkNetworkError.error("getRandomBeer API 에러")
            }
            .flatMap(maxPublishers: .max(1)) { data in
                decode(data.data)
            }
            .eraseToAnyPublisher()
    }
}

private extension PunkNetworkImpl {
    struct PunkAPI {
        static let scheme = "https"
        static let host = "api.punkapi.com"
        static let path = "/v2/beers"
    }
    
    func makeGetBeersComponents(page: Int?) -> URLComponents {
        var components = URLComponents()
        components.scheme = PunkAPI.scheme
        components.host = PunkAPI.host
        components.path = PunkAPI.path
        if let page = page {
            components.queryItems = [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "per_page", value: "80")
            ]
        } else {
            components.queryItems = [
                URLQueryItem(name: "per_page", value: "80")
            ]
        }
        
        return components
    }
    
    func makeGetBeerComponents(id: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = PunkAPI.scheme
        components.host = PunkAPI.host
        components.path = PunkAPI.path + "/\(id)"
        
        return components
    }
    
    func makeGetRandomBeerComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = PunkAPI.scheme
        components.host = PunkAPI.host
        components.path = PunkAPI.path + "/random"
        
        return components
    }
}
