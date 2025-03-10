//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Johanan Edmeade on 1/6/24.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var startPoint = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel : LocationSearchViewModel
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    Circle()
                        .fill(Color(.black))
                        .frame(width: 6, height: 6)
                    
                }
                
                VStack{
                    TextField("Current Location", text: $startPoint)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    
                    TextField("Destination", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            //list view
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(viewModel.results, id: \.self ){ address in
                        SearchAddressView(title: address.title, subtitle: address.subtitle)
                            .onTapGesture {
                                withAnimation(.spring){
                                    viewModel.selectLocation(address)
                                    mapState = .locationSelected
                                }
                            }
                    }
                }
            }
        }
        .background(Color.theme.backgroundColor)
    }
}

#Preview {
    LocationSearchView(mapState: .constant(.searchingForLocation))
}
