//
//  ImageAndTextView.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 29/12/2022.
//

import SwiftUI

struct ImageAndTextView: View {

    let breed: Breed

    var body: some View {
        AsyncImage(url: breed.imageURL, transaction: .init(animation: .default)) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .frame(width: 80, height: 80)
            default:
                Image(systemName: .pawImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
            }
        }
        Text(breed.name)
            .font(.headline)
    }
}

struct ImageAndTextView_Previews: PreviewProvider {
    static var previews: some View {
        ImageAndTextView(breed: BreedsImagesProviderMock.testModel[0])
    }
}
