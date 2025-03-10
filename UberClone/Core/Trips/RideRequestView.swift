//
//  RideRequestView.swift
//  UberClone
//
//  Created by Johanan Edmeade on 1/16/24.
//

import SwiftUI

struct RideRequestView: View {
    
    @EnvironmentObject var viewModel : LocationSearchViewModel
    @State var selectedRideType : RideType = .UberX
    var body: some View {
        VStack(spacing: 10){
            //current location to selected destination w/ time
            Capsule()
                .frame(width: 60, height:6)
                .foregroundColor(Color(.systemGroupedBackground))
                .padding(.top, 10)
            VStack{
                HStack{
                    VStack{
                        Circle()
                            .fill(Color(.systemGray3))
                            .frame(width: 8, height: 8)
                        Rectangle()
                            .fill(Color(.systemGray3))
                            .frame(width: 1, height: 24)
                        Circle()
                            .fill(Color(.black))
                            .frame(width: 8, height: 8)
                        
                    }
                    HStack{
                        VStack(alignment: .leading){
                            Text("Current Location")
                                .font(.subheadline)
                                .frame(height: 32)
                                .padding(.bottom, 8)
                                .foregroundStyle(Color(.systemGray2))
                            Text(viewModel.selectedLocation?.title ?? "")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(height: 32)
                        }
                        .padding(.horizontal)
                        Spacer()
                        VStack{
                            Text(viewModel.pickupTime ?? "")
                                .font(.subheadline)
                                .frame(height: 32)
                                .padding(.bottom, 8)
                                .foregroundStyle(Color(.systemGray2))
                            Text(viewModel.dropOfTime ?? "")
                                .font(.subheadline)
                                .frame(height: 32)
                                .foregroundStyle(Color(.systemGray2))
                        }
                        
                    }
                    
                    
                    
                }
                //divider
                Divider()
                    .padding(.horizontal, 30)
                //title
                
                Text("Suggested Rides")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundColor(.gray)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                
                //why: allows for scaling. updates through enum ridetype
                ScrollView(.horizontal){
                    HStack(spacing: 12){
                        //why: all cases returns all cases in array. easy to loop through
                        ForEach(RideType.allCases){ rideType in
                            VStack(alignment: .leading){
                                Image(rideType.image)
                                    .resizable()
                                    .scaledToFit()
                                VStack(alignment: .leading, spacing: 4){
                                    Text(rideType.description)
                                        .font(.system(size: 14, weight: .semibold))
                                        .lineLimit(1)
                                    Text(viewModel.computeRidePrice(forType: rideType).toCurrency())
                                        .font(.system(size: 14, weight: .semibold))
                                }
                                .padding(.horizontal)
                            }
                            .frame(width: 112, height: 140)
                            .foregroundStyle(Color(selectedRideType == rideType ? .white : Color.theme.primaryFontColor))
                            .background(selectedRideType == rideType ? Color(.systemBlue) : Color.theme.secondaryBackgroundColor)
                            .scaleEffect(selectedRideType == rideType ? 1.2 : 1.0)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                withAnimation(.spring) {
                                    selectedRideType = rideType
                                }
                            }
                        }
                        //                RideOptionsView()
                        //                RideOptionsView()
                        //                RideOptionsView()
                    }
                }
                //payment optipns: component?
                Divider()
                    .padding(.vertical, 8)
                Button{
                    //action
                }label: {
                    HStack{
                        Text("Visa")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(6)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .foregroundStyle(.white)
                        
                        
                        Text("*** 1234")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.primary)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.primary)
                            .imageScale(.medium)
                    }
                    .padding(.horizontal)
                }
                .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                .background(Color(.systemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                //button to confirm ride
                Button{
                    
                }label: {
                    Text("Confirm Ride")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
                .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
        }
        .padding(.bottom, 20)
        .background(Color.theme.backgroundColor)
        .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20, topTrailing:  20)))
    }
}
    #Preview {
        RideRequestView()
    }
