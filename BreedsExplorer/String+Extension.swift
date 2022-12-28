//
//  String+Extension.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 28/12/2022.
//

import SwiftUI

extension String {

    static let pawImage = "pawprint.circle.fill"
    static let searchImage = "magnifyingglass.circle.fill"
    static let gridIcon = "square.grid.2x2"
    static let listIcon = "list.bullet"

    static let breeds = "Breeds"
    static let search = "Search"
    static let grid = "Grid"
    static let list = "List"
}

extension Color {

    static let breedsAccentColor = Color(red: 239, green: 153, blue: 122)

    static let breedsSecondaryColor = Color(red: 251, green: 246, blue: 244)

    static let breedsPrimaryColor = Color(red: 235, green: 99, blue: 86)

    private init(red: Int, green: Int, blue: Int) {

        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0)
    }
}
