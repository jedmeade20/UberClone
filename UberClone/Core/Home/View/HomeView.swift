//
//  HomeView.swift
//  UberClone
//
//  Created by Johanan Edmeade on 1/4/24.
//

import SwiftUI

struct HomeView: View {
    //enum used to change state vs booleans
    @State private var mapState = MapViewState.noInput
    //one instance across entire app
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top){
                UberMapsViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                if mapState == .searchingForLocation{
                    LocationSearchView(mapState: $mapState)
                }else if mapState == .noInput {
                    LocationSearchActivationView()
                        .padding(.top, 72)
                        .onTapGesture {
                            withAnimation(.spring) {
                                mapState = .searchingForLocation
                            }
                        }
                }
                
                MapViewActionButtonView(mapState: $mapState)
                    .padding(.leading)
                    .padding(.top, 4)
                
            }
            if mapState == .locationSelected || mapState == .polyLineAdded{
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea(edges: .bottom)
        //used to update user location on this page
        .onReceive(LocationManager.shared.$userLocation, perform: { location in
            locationViewModel.userMainLocation = location
        })
    }
}

#Preview {
    HomeView()
}
