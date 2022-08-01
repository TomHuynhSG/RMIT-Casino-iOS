//
//  LogoView.swift
//  RMIT Casino
//
//  Created by Tom Huynh on 8/1/22.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("rmit-casino-logo")
            .resizable()
            .scaledToFit()
            .frame(minHeight: 130, idealHeight: 170, maxHeight: 200, alignment: .center)
            .modifier(ShadowModifier())
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
