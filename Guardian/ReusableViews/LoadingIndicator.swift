//
//  LoadingIndicator.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 11/10/2021.
//

import SwiftUI

struct LoadingIndicator: ViewModifier {
    let width = UIScreen.main.bounds.width * 0.3
    let height =  UIScreen.main.bounds.width * 0.3

    func body(content: Content) -> some View {
        return ZStack {
            content
                .disabled(true)
                .blur(radius: 2)


            VStack{}
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
            .edgesIgnoringSafeArea(.all)


            ProgressView()
                .frame(width: width, height: height)
                .background(Color.white)
                .cornerRadius(width)
                .opacity(1)
                .shadow(color: Color.gray.opacity(0.5), radius: 4.0, x: 1.0, y: 2.0)
        }
    }

}

extension View {
    func loadingIndicator(_ condition: Bool) -> some View {
        if condition {
            return AnyView(modifier(LoadingIndicator()))
        } else {
            return AnyView(self)
        }
    }
}
