//
//  RecipeDetail.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 07/10/2021.
//

import SwiftUI

struct RecipeDetail: View {

    var item: RecipeDetail.Item

    @Environment(\.colorScheme) var colorScheme

    var body: some View {

        ScrollView {
            AsyncImageWithPlaceholder(placeholderImageName: "placeholder",
                                      imageURL: item.imageURL,
                                      staticImage: item.image)
                .overlay(TextOverlay(line0: item.author.name.first ?? "", line1: item.author.name.last ?? ""))
            

            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .accessibility(label: Text("item.title-\(item.title)"))
                Divider()
                Text(item.attributedBody)
                    .font(.body)
                    .accessibility(label: Text("item.content-\(item.accessibleLabelBody)"))
            }
            .padding()
        }
        .ignoresSafeArea(edges: .top)
    }
}



struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        let name = Name(first: "Thomas", last: "Brody")
        let author = Author(name: name, pictureURL: nil)
        let item = RecipeDetail.Item(author: author,
                                     title: "Kimchi & Friends",
                                     body: "Interesting recipe",
                                     image: Image("test0"),
                                     imageURL: nil)
        Group {
            RecipeDetail(item: item)
                .preferredColorScheme(.dark)

            RecipeDetail(item: item)
                .preferredColorScheme(.light)
        }
    }
}
