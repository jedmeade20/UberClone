//
//  RideOptionsView.swift
//  UberClone
//
//  Created by Johanan Edmeade on 1/16/24.
//

import SwiftUI

struct RideOptionsView: View {
    var body: some View {
        Image(systemName: "car.circle.fill")
            .resizable()
            .frame(width: 100, height: 100, alignment: .center)
            .foregroundColor(Color.red)
            .scaleEffect(CGSize(width: 0.9, height: 1.3), anchor: .leading)
            .border(Color.gray)
    }
}

#Preview {
    RideOptionsView()
}
