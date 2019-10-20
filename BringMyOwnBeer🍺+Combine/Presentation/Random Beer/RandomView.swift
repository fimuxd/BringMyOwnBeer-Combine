//
//  RandomView.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/15.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import SwiftUI

struct RandomView: View {
    @ObservedObject var viewModel: RandomViewModel
    
    init(viewModel: RandomViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                content()
                Spacer()
                Button(action: { self.viewModel.getRandomBeer() }) {
                    Text("I'm feeling lucky")
                        .frame(maxWidth: .infinity, maxHeight: 56)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(4)
                }
                .padding([.leading, .trailing], 10)
            }
            .navigationBarTitle("아무거나 검색")
            .padding()
        }
    }
}

private extension RandomView {
    func content() -> some View {
        if let beer = viewModel.beer {
            return AnyView(details(for: beer))
        } else {
            return AnyView(loading)
        }
    }
    
    func details(for beer: Beer) -> some View {
        BeerResultView(beer: beer)
    }
    
    var loading: some View {
        Text("")
    }
}

struct RandomView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyService = PunkNetworkDummy()
        let randomViewModel = RandomViewModel(punkService: dummyService)
        
        return ForEach(["iPhone 8", "iPhone 8 Plus"], id: \.self) { deviceName in
            RandomView(viewModel: randomViewModel)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
