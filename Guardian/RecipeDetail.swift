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
        let body: String
        let image: Image?
        let imageURL: URL?



        var attributedBody: AttributedString {

            if let data = body.data(using: .utf8),
               let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                return AttributedString(attributedString)
            }
            return AttributedString("No content to show")
        }
        
        var accessibleLabelBody: String {
            return String(body.prefix(10))
        }

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
        let item = RecipeDetail.Item(author: Name(first: "Thomas", last: "Brody"),
                                     title: "Kimchi & Friends",
                                     body: "Interesting recipe",
                                     image: Image("test0"),
                                     imageURL: nil)
        RecipeDetail(item: item)
    }
}
