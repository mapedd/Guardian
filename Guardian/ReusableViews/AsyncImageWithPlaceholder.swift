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
                                    ProgressView()
                                }
                                .opacity(0.3)

                            case .success(let image):
                                image.resizable()
                            case .failure:
                                Image(placeholderImageName)
                                    .resizable()
                            @unknown default:
                                EmptyView()
                            }
                        }
        } else if let image = staticImage {
            image.resizable()
        } else {
            Image(placeholderImageName)
                .resizable()
        }
    }
}

struct AsyncImageWithPlaceholder_Previews: PreviewProvider {
    // test 3 cases - success, loading, static
    static var previews: some View {
        Group {
            AsyncImageWithPlaceholder(placeholderImageName: "placeholder",
                                      imageURL: nil,
                                      staticImage: nil)
                .frame(width: 300, height: 200)

            AsyncImageWithPlaceholder(placeholderImageName: "placeholder",
                                      imageURL: nil,
                                      staticImage: Image("test0"))
                .frame(width: 300, height: 200)

            AsyncImageWithPlaceholder(placeholderImageName: "placeholder",
                                      imageURL: URL(string: "https://media.guim.co.uk/5bf2f99f2fe5e722a9bfbfdc8fb4ad02d736973e/201_1677_5591_3355/500.jpg")!,
                                      staticImage: nil)
                .frame(width: 300, height: 200)
        }
    }
}
