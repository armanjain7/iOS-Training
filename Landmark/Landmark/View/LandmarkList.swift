//
//  LandmarkList.swift
//  Landmark
//
//  Created by Raramuri on 29/07/24.
//

import SwiftUI

struct LandmarkList: View {
    @Environment(ModelData.self) var modelData
    @State private var showFav = false
    var filteredLandmarks: [Landmark] {
        modelData.landmark.filter { landmark in
                (!showFav || landmark.isFavorite)
            }
        }
    var body: some View {
        NavigationSplitView{
            List{
                Toggle(isOn: $showFav){
                    Text("Favorite")
                }
                ForEach(filteredLandmarks){ landmark in
                    NavigationLink{
                        LandmarkDetail(landmark: landmark)
                    } label:{
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .animation(.default,value: filteredLandmarks)
            .navigationTitle("Landmarks")
        }detail: {
            Text("Select a Landmark")
        }
    }
}
#Preview {
    LandmarkList()
        .environment(ModelData())
}
