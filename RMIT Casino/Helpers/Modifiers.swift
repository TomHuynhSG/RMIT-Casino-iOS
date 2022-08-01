//
//  Modifiers.swift
//  RMIT Casino
//
//  Created by Tom Huynh on 8/1/22.
//

import SwiftUI

struct ShadowModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .shadow(color:Color("ColorBlackTransparent"), radius: 7)
    }
}


struct scoreNumberStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .heavy, design: .rounded))
    }
}

struct scoreLabelStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
}

struct scoreCapsuleStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(
                Capsule()
                    .foregroundColor(Color("ColorBlackTransparent")))
    }
}

struct ReelImageModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 140, idealWidth: 200, maxWidth: 220, alignment: .center)
            .modifier(ShadowModifier())
    }
}

struct IconImageModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 60, idealWidth: 70, maxWidth: 80, alignment: .center)
            .modifier(ShadowModifier())
    }
}
