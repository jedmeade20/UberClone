//
//  Color.swift
//  UberClone
//
//  Created by Johanan Edmeade on 1/19/24.
//

import Foundation
import SwiftUI

extension Color{
    static let theme = ColorTheme()
}

struct ColorTheme{
    let backgroundColor = Color("backgroundColor")
    let secondaryBackgroundColor = Color("secondaryBackgroundColor")
    let primaryFontColor = Color("primaryFontColor")
}
