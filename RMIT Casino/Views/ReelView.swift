//
//  ReelView.swift
//  RMIT Casino
//
//  Created by Tom Huynh on 8/2/22.
//

import SwiftUI

struct ReelView: View {
    var body: some View {
        Image("reel")
            .resizable()
            .modifier(ReelImageModifier())
    }
}

struct ReelView_Previews: PreviewProvider {
    static var previews: some View {
        ReelView()
            .previewLayout(.sizeThatFits)
    }
}
