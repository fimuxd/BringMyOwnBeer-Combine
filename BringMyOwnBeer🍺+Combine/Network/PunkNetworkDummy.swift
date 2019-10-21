//
//  PunkNetworkDummy.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/20.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import Foundation
import Combine

let beersData: [Beer] = load("BeersData.json")

func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

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

extension PunkNetworkDummy {
    
}
