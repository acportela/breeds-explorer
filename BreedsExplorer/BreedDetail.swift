//
//  BreedDetail.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

struct BreedDetail: View {

    let breed: BreedImage

    var body: some View {
        VStack(alignment: .center, spacing: 16.0) {
            Image(systemName: .pawImage)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            Text(breed.name)
            Spacer()
        }
        .padding(.top)
        .foregroundColor(.breedsPrimaryColor)
    }
}

struct BreedDetail_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetail(breed: BreedsImagesProviderMock.testModel[0])
    }
}
