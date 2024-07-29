//
//  LandmarkApp.swift
//  Landmark
//
//  Created by Raramuri on 29/07/24.
//

import SwiftUI

@main
struct LandmarkApp: App {
    @State private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
            
        }
    }
}
