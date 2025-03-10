//
//  MapViewActionButtonView.swift
//  UberClone
//
//  Created by Johanan Edmeade on 1/6/24.
//

import SwiftUI

struct MapViewActionButtonView: View {
    @Binding var mapState : MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        Button {
            //some action
            withAnimation(.spring) {
                actionForState(mapState)
            }
        } label: {
            Image(systemName: imageForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 6)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

    }
    //changes button action
    func actionForState(_ state: MapViewState){
        switch state{
        case .noInput:
            print("DEBUG: no input")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected, .polyLineAdded:
            mapState = .noInput
            viewModel.selectedLocation = nil
        }
    }
    // changes image for button 
    func imageForState(_ state: MapViewState) -> String{
        switch state{
        case .noInput:
            return "line.3.horizontal"
        case .locationSelected,.searchingForLocation:
            return "arrow.backward"
        default:
            return "line.3.horizontal"
        }
    }
}

#Preview {
    MapViewActionButtonView(mapState: .constant(.noInput))
}
