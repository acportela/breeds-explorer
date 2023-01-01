//
//  ImageAndTextView.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 29/12/2022.
//

import SwiftUI

struct ImageAndTextView: View {

    let breed: Breed
    let imageSize: CGFloat

    var body: some View {
        AsyncImage(url: breed.imageURL, transaction: .init(animation: .default)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .frame(width: imageSize, height: imageSize)
            default:
                Image(systemName: .pawImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize * 0.8, height: imageSize * 0.8)
            }
        }
        Text(breed.name)
    }
}

struct ImageAndTextView_Previews: PreviewProvider {
    static var previews: some View {
        ImageAndTextView(breed: BreedsImagesProviderMock.testModel[0], imageSize: 100)
    }
}
