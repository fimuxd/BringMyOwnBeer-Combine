//
//  ImageLoader.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/15.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import Combine
import SwiftUI

protocol ImageLoadable {
    func loadImage(id: Int) -> AnyPublisher<UIImage, Error>
}

extension URL: ImageLoadable {
    enum ImageLoadingError: Error {
        case incorrectData
    }

    func loadImage(id: Int) -> AnyPublisher<UIImage, Error> {
        if let retrieveImage = self.retrieveImage(forKey: "\(id)") {
            return retrieveImage.loadImage(id: id)
        }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: self)
            .tryMap { data, _ in
                guard let image = UIImage(data: data) else {
                    throw ImageLoadingError.incorrectData
                }
                
                self.store(image: image, forKey: "\(id)")
                return image
            }
            .eraseToAnyPublisher()
    }
    
    private func store(image: UIImage, forKey key: String) {
        if let pngRepresentation = image.pngData() {
            UserDefaults.standard.set(pngRepresentation, forKey: key)
        }
    }
    
    private func retrieveImage(forKey key: String) -> UIImage? {
        guard let imageData = UserDefaults.standard.object(forKey: key) as? Data,
            let image = UIImage(data: imageData) else {
            return nil
        }
        return image
    }
}

extension UIImage: ImageLoadable {
    func loadImage(id: Int) -> AnyPublisher<UIImage, Error> {
        return Just(self)
            // Just's Failure type is Never
            // Our protocol expect's it to be Error, so we need to `override` it
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

final class ImageLoader: ObservableObject {
    var objectWillChange: AnyPublisher<UIImage?, Never> = Empty().eraseToAnyPublisher()
    
    @Published private(set) var image: UIImage? = nil
    
    private let loadable: ImageLoadable
    private var cancellable: AnyCancellable?
    
    static var loadCount = 0
    
    init(loadable: ImageLoadable, id: Int) {
        self.loadable = loadable

        self.objectWillChange = $image.handleEvents(
            receiveSubscription: { [weak self] sub in
                self?.load(id: id)
            },
            receiveCancel: { [weak self] in
                self?.cancellable?.cancel()
            }
        ).eraseToAnyPublisher()
    }
    
    private func load(id: Int) {
        guard image == nil else {
            return
        }
        
        cancellable = loadable
            .loadImage(id: id)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] image in
                    self?.image = image
                }
            )
    }
}
