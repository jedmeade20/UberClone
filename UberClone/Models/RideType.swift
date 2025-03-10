//
//  RideType.swift
//  UberClone
//
//  Created by Johanan Edmeade on 1/17/24.
//

import Foundation
//why: instead of using input parameters, this hold all options and can update throughout app on case by case basis
enum RideType: Int, CaseIterable, Identifiable{
    
    case UberX
    case UberBlack
    case UberXL
    case UberComfort
    
    var id: Int {return rawValue }
    
    var description: String{
        switch self {
        case .UberX:
            return "UberX"
        case .UberBlack:
            return "UberBlack"
        case .UberXL:
            return "UberXL"
        case .UberComfort:
            return "UberComfort"
        }
    }
    var image: String{
        switch self {
        case .UberX:
            return "uber-x"
        case .UberBlack:
            return "uber-black"
        case .UberXL:
            return "uber-x"
        case .UberComfort:
            return "uber-black"
        }
    }
    var pricing: Double{
        switch self{
        case .UberX:
            return 5
        case .UberBlack:
            return 20
        case .UberXL:
            return 10
        case .UberComfort:
            return 16
        }
    }
    func fairCalculator(distanceInMeters: Double) -> Double{
        let distanceInMiles = distanceInMeters / 1609.34
        switch self{
        case .UberX:
            return distanceInMiles * 1.5 + pricing
        case .UberBlack:
            return distanceInMiles * 3.0 + pricing
            
        case .UberXL:
            return distanceInMiles * 2.0 + pricing

        case .UberComfort:
            return distanceInMiles * 1.7 + pricing

        }
    }
}
