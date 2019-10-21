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
    @ObservedObject var imageLoader: ImageLoader
    
    init(beer: Beer) {
        self.beer = beer
        self.imageLoader = ImageLoader(loadable: URL(string: beer.imageURL ?? "") ?? UIImage(imageLiteralResourceName: "placeHolderNoBeer"), id: beer.id ?? 0)
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(uiImage: imageLoader.image ?? UIImage(imageLiteralResourceName: "placeHolderNoBeer"))
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

struct BeerRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BeerRow(beer: beersData[0])
            BeerRow(beer: beersData[10])
            BeerRow(beer: beersData[20])
        }
        .previewLayout(.fixed(width: 450, height: 150))
    }
}
