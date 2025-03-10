//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Johanan Edmeade on 1/4/24.
//

import SwiftUI

@main
struct UberCloneApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
