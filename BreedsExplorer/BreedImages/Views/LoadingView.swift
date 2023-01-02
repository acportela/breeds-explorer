//
//  LoadingView.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 29/12/2022.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {

    let isLoading: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(isLoading)
                VStack(alignment: .center) {
                    Text(String.loading)
                    ProgressView()
                }
                .frame(width: geometry.size.width / 3, height: geometry.size.height / 5)
                .background(Color.breedsSecondaryColor)
                .cornerRadius(24)
                .foregroundColor(Color.breedsPrimaryColor)
                .opacity(isLoading ? 1 : 0)
            }
        }
    }
}

private extension String {

    static let loading = "Loading..."
}
