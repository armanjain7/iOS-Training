//
//  LandmarkDetail.swift
//  Landmark
//
//  Created by Raramuri on 29/07/24.
//

import SwiftUI

struct LandmarkDetail: View {
    @Environment(ModelData.self) var modelData
    var landmark: Landmark
    var LandmarkIndex: Int{
        modelData.landmark.firstIndex(where: {$0.id == landmark.id})!
    }
    var body: some View {
        @Bindable var modelData = modelData
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .frame(height: 300)
            CircleImageView(image: landmark.image)
                .offset(y:-130)
                .padding(.bottom, -130)
            VStack(alignment: .leading) {
                HStack{
                    Text(landmark.name)
                        .font(.title)
                        .foregroundStyle(.green)
                    FavButton(isSet: $modelData.landmark[LandmarkIndex].isFavorite)
                }
                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                Divider()
                
                Text("About \(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
            }
            .padding()
            Spacer()
                
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let modelData = ModelData()
    return LandmarkDetail(landmark: modelData.landmark[0])
        .environment(modelData)
}
