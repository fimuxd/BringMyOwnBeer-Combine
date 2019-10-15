//
//  SearchView.swift
//  BringMyOwnBeer🍺+Combine
//
//  Created by Bo-Young PARK on 2019/10/15.
//  Copyright © 2019 Boyoung Park. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                SearchBar(text: $viewModel.id)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                content()
                Spacer()
            }
            .navigationBarTitle("ID 검색")
            .padding()
        }
    }
}

private extension SearchView {
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
        Text("\(viewModel.id)번 맥주를 불러오는 중...")
            .foregroundColor(.gray)
    }
}
