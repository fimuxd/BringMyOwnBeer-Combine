//
//  SearchResultView.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/15.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import SwiftUI

struct SearchResultView: View {
    var beer: Beer
    @ObservedObject var imageURL: ImageURL
    
    init(beer: Beer) {
        self.beer = beer
        self.imageURL = ImageURL(imageURL: beer.imageURL)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: imageURL.data.isEmpty ? UIImage() : UIImage(data: imageURL.data)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 240.0, height: 240.0, alignment: .center)
            Text("\(beer.id ?? 0)")
                .font(.system(size: 14, weight: .light, design: .default))
                .foregroundColor(.blue)
            Text(beer.name ?? "알 수 없는 맥주")
                .font(.system(size: 18, weight: .bold, design: .default))
                .foregroundColor(.black)
                .lineLimit(1)
            Text(beer.description ?? "")
                .font(.system(size: 16, weight: .light, design: .default))
                .foregroundColor(.gray)
        }
    }
}
