//
//  BeerRow.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/14.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import SwiftUI
import Combine

struct BeerRow: View {
    var beer: Beer
    @ObservedObject var imageURL: ImageURL
    
    init(beer: Beer) {
        self.beer = beer
        self.imageURL = ImageURL(imageURL: beer.imageURL)
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Image(uiImage: imageURL.data.isEmpty ? UIImage() : UIImage(data: imageURL.data)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120.0, height: 120.0, alignment: .center)
                VStack(alignment: .leading) {
                    Text("\(beer.id ?? 0)")
                        .font(Font.system(size: 14, weight: .light, design: .default))
                        .foregroundColor(.blue)
                    Text(beer.name ?? "unknown beer")
                        .font(Font.system(size: 18, weight: .heavy, design: .default))
                        .foregroundColor(.black)
                        .lineLimit(1)
                    Text(beer.description ?? "")
                        .font(Font.system(size: 16, weight: .light, design: .default))
                        .foregroundColor(.gray)
                        .lineLimit(3)
                }
            }
        }
    }
}

class ImageURL: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(imageURL: String?) {
        guard let url = URL(string: imageURL ?? "") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}
