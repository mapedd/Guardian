//
//  TextOverlay.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 08/10/2021.
//

import SwiftUI

struct TextOverlay: View {
    var line0: String
    var line1: String

    var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
                       startPoint: .bottom,
                       endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle().fill(gradient)
            VStack(alignment: .leading) {
                Text(line0)
                    .font(.title)
                    .bold()
                Text(line1)
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}
struct TextOverlay_Previews: PreviewProvider {
    static var previews: some View {
        TextOverlay(line0: "LINE 0", line1: "LINE 1")
    }
}
