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
                    .blur(radius: isLoading ? 1 : 0)

                VStack {
                    Text("Loading...")
                    ProgressView()
                }
                .frame(width: geometry.size.width / 2, height: geometry.size.height / 5)
                .background(Color.breedsSecondaryColor)
                .foregroundColor(Color.breedsPrimaryColor)
                .cornerRadius(20)
                .opacity(isLoading ? 1 : 0)
            }
        }
    }
}
