//
//  SearchAddressView.swift
//  UberClone
//
//  Created by Johanan Edmeade on 1/7/24.
//

import SwiftUI

struct SearchAddressView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
            VStack(alignment: .leading){
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(Color(.systemGray))
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
//        .frame(width: UIScreen.main.bounds.width - 30, height: 40)
        .padding(.leading)
    }
}

#Preview {
    SearchAddressView(title: "Home", subtitle: "8137 Estate Pearl")
        .accessibilityLabel("Home")
}
