//
//  BreedDetailHeader.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 30/12/2022.
//

import SwiftUI

struct BreedDetailHeader: View {

    let imageUrl: URL?

    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            AsyncImage(url: imageUrl, transaction: .init(animation: .default)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                        .frame(height: 120)
                default:
                    Image(systemName: .pawImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color.breedsPrimaryColor)
                }
            }
            Spacer()
        }
        .padding(.bottom, 24)
    }
}
