//
//  DetailItem.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 11/10/2021.
//

import Foundation
import SwiftUI

extension RecipeDetail {
    struct Item {
        let author: Author
        let title: String
        let body: String
        let image: Image?
        let imageURL: URL?

        var options: [NSAttributedString.DocumentReadingOptionKey : Any] {
            return [.documentType: NSAttributedString.DocumentType.html]
        }

        var htmlWithCSS: String {
            return """
            <html>
              <head>
                <style type="text/css">

            :root {
              color-scheme: light dark;
            }

                  body {
            
                    font-size: 15px;
                    font-family: -apple-system, Avenir, Arial, sans-serif;
                    color: #eaeaea;
                  }

                    @media (prefers-color-scheme: dark) {

                        body {
                            color: #393939;
                        }
                    }

                </style>
              </head>
              <body>
               \(body)
              </body>
            </html>
            """
        }

        var attributedBody: AttributedString {

            if let data = htmlWithCSS.data(using: .utf8),
               let attributedString = try? NSAttributedString(data: data,
                                                              options:options,
                                                              documentAttributes: nil) {
                return AttributedString(attributedString)
            }
            return AttributedString("No content to show")
        }

        var accessibleLabelBody: String {
            return String(body.prefix(10))
        }

    }
}
