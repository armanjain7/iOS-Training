//
//  FavButton.swift
//  Landmark
//
//  Created by Raramuri on 29/07/24.
//

import SwiftUI

struct FavButton: View {
    @Binding var isSet: Bool
    var body: some View {
        Button{
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundStyle(isSet ? .yellow : .gray)
        }
    }
}

#Preview {
    FavButton(isSet: .constant(true))
}
