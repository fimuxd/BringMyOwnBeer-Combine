//
//  BeerResultView.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/15.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import SwiftUI

struct BeerResultView: View {
    var beer: Beer
    @ObservedObject var imageLoader: ImageLoader
    
    init(beer: Beer) {
        self.beer = beer
        self.imageLoader = ImageLoader(loadable: URL(string: beer.imageURL ?? "") ?? UIImage(imageLiteralResourceName: "placeHolderNoBeer"), id: beer.id ?? 0)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: imageLoader.image ?? UIImage(imageLiteralResourceName: "placeHolderNoBeer"))
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

struct BeerResultView_Previews: PreviewProvider {
    static var previews: some View {
        return ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            BeerResultView(beer: beersData[18])
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
