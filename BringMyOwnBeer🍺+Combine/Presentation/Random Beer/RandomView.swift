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
                content()
                Spacer()
                Button(action: { self.viewModel.getRandomBeer() }) {
                    Text("I'm feeling lucky")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(4)
                }
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

