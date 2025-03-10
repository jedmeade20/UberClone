//
//  MapViewState.swift
//  UberClone
//
//  Created by Johanan Edmeade on 1/14/24.
//

import Foundation

//used to manage app state: if using rides or not etc, switch statements?

enum MapViewState{
    case noInput
    case searchingForLocation
    case locationSelected
    case polyLineAdded
}
