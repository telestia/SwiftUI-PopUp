//
//  PopupCard.swift
//  Video Downloader
//
//  Created by Harun SUBAŞI on 12.08.2025.
//

import Foundation
import SwiftUI

public struct PopupCard<Content: View>: View {
    let width: CGFloat
    let height: CGFloat
    let background: Color
    let cornerRadius: CGFloat
    @ViewBuilder var content: Content
    
    public init(
        width: CGFloat = 225,
        height: CGFloat = 280,
        background: Color = Color(red: 0.09, green: 0.09, blue: 0.09),
        cornerRadius: CGFloat = 20,
        @ViewBuilder content: () -> Content
    ) {
        self.width = width
        self.height = height
        self.background = background
        self.cornerRadius = cornerRadius
        self.content = content()
    }
    
    public var body: some View {
        VStack { content }
            .frame(width: width, height: height)
            .background(background)
            .cornerRadius(cornerRadius)
            .shadow(radius: 8)
    }
}
