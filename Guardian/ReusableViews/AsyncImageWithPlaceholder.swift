//
//  AsyncImageWithPlaceholder.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 11/10/2021.
//

import SwiftUI

struct AsyncImageWithPlaceholder: View {
    let placeholderImageName: String
    let imageURL: URL?
    let staticImage: Image?

    var body: some View {
        if imageURL != nil {
            AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                ZStack {
                                    Image(placeholderImageName)
                                        .resizable()
                                        .cornerRadius(10)
                                        .aspectRatio(3.0/2.0, contentMode: .fill)
                                    ProgressView()
                                }
                                .opacity(0.3)


                            case .success(let image):
                                image.resizable()
                                    .cornerRadius(10)
                                    .aspectRatio(3.0/2.0, contentMode: .fit)
                            case .failure:
                                Image("placeholder")
                                    .resizable()
                                    .cornerRadius(10)
                                    .aspectRatio(3.0/2.0, contentMode: .fill)
                            @unknown default:
                                // Since the AsyncImagePhase enum isn't frozen,
                                // we need to add this currently unused fallback
                                // to handle any new cases that might be added
                                // in the future:
                                EmptyView()
                            }
                        }
        } else if let image = staticImage {
            image.resizable()
                .cornerRadius(10)
                .aspectRatio(3.0/2.0, contentMode: .fit)
        }
    }
}
//
//struct AsyncImageWithPlaceholder_Previews: PreviewProvider {
//    static var previews: some View {
//        AsyncImageWithPlaceholder()
//    }
//}
