//
//  LoadingView.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 29/12/2022.
//

import SwiftUI

enum ViewState {
    case content
    case loading
}

struct LoadingView<Content>: View where Content: View {

    let viewState: ViewState
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(viewState == .loading)
                    .blur(radius: viewState == .loading ? 3 : 0)

                VStack {
                    Text("Loading...")
                    ProgressView()
                }
                .frame(width: geometry.size.width / 2, height: geometry.size.height / 5)
                .background(Color.breedsSecondaryColor)
                .foregroundColor(Color.breedsPrimaryColor)
                .cornerRadius(20)
                .opacity(viewState == .loading ? 1 : 0)
            }
        }
    }
}
