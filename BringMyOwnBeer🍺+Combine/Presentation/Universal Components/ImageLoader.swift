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
    func loadImage() -> AnyPublisher<UIImage, Error>
}

extension URL: ImageLoadable {
    enum ImageLoadingError: Error {
        case incorrectData
    }

    func loadImage() -> AnyPublisher<UIImage, Error> {
        URLSession
            .shared
            .dataTaskPublisher(for: self)
            .tryMap { data, _ in
                guard let image = UIImage(data: data) else {
                    throw ImageLoadingError.incorrectData
                }
                
                return image
            }
            .eraseToAnyPublisher()
    }
}

extension UIImage: ImageLoadable {
    func loadImage() -> AnyPublisher<UIImage, Error> {
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
    
    init(loadable: ImageLoadable) {
        self.loadable = loadable

        self.objectWillChange = $image.handleEvents(receiveSubscription: { [weak self] sub in
            self?.load()
        }, receiveCancel: { [weak self] in
            self?.cancellable?.cancel()
        }).eraseToAnyPublisher()
    }
    
    private func load() {
        guard image == nil else { return }
        
        cancellable = loadable
            .loadImage()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] image in
                    self?.image = image
                }
            )
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}

struct ImageLoadingView: View {
    @ObservedObject private var imageLoader: ImageLoader
    
    init(image: URL) {
        imageLoader = ImageLoader(loadable: image)
    }
    
    var body: some View {
        return ZStack {
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
                    .resizable()
            }
        }
    }
}
