//
//  RecipeDetail.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 07/10/2021.
//

import SwiftUI

struct Name {
    let first: String
    let last: String
}

struct RecipeDetail: View {
    struct Item {
        let author: Name
        let title: String
        let body: AttributedString
        let image: Image?
        let imageURL: URL?
    }
    var item: Item

    var body: some View {

        ScrollView {
            VStack {
                if item.imageURL != nil {
                    AsyncImage(url: item.imageURL) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                Image("placeholder")
                                    .resizable()
                                    .aspectRatio(3.0/2.0, contentMode: .fill)
                                ProgressView()
                            }
                            .opacity(0.3)


                        case .success(let image):
                            image.resizable()
                                .aspectRatio(3.0/2.0, contentMode: .fit)
                        case .failure:
                            Image("placeholder")
                                .resizable()
                                .aspectRatio(3.0/2.0, contentMode: .fill)
                        @unknown default:
                            // Since the AsyncImagePhase enum isn't frozen,
                            // we need to add this currently unused fallback
                            // to handle any new cases that might be added
                            // in the future:
                            EmptyView()
                        }
                    }
                } else if let image = item.image {
                    image.resizable()
                        .aspectRatio(3.0/2.0, contentMode: .fit)
                }

            }
            .overlay(TextOverlay(line0: "Thomas", line1: "Brody"))

            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                Divider()
                Text(item.body)
                    .font(.body)
            }
            .padding()
        }
    }
}



struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        let item = RecipeDetail.Item(author: Name(first: "Thomas", last: "Brody"),
                                     title: "Kimchi & Friends",
                                     body: AttributedString("Interesting recipe"),
                                     image: Image("test0"),
                                     imageURL: nil)
        RecipeDetail(item: item)
    }
}
