//
//  LandmarkRow.swift
//  Landmark
//
//  Created by Raramuri on 29/07/24.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50,height: 50)
            Text(landmark.name)
            Spacer()
            if landmark.isFavorite{
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

#Preview {
    let landmark = ModelData().landmark
    return Group{
        LandmarkRow(landmark: landmark[0])
        LandmarkRow(landmark: landmark[1])
    }
}
