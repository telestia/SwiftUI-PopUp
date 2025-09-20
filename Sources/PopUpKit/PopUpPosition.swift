//
//  PopUpPosition.swift
//  Video Downloader
//
//  Created by Harun SUBAŞI on 12.08.2025.
//

import Foundation
import SwiftUI

public enum PopUpPosition {
    case center, top, bottom
    
    var alignment: Alignment {
        switch self {
        case .center: return .center
        case .top:    return .top
        case .bottom: return .bottom
        }
    }
    
    var transition: AnyTransition {
        switch self {
        case .center: return .scale.combined(with: .opacity)
        case .top:    return .move(edge: .top).combined(with: .opacity)
        case .bottom: return .move(edge: .bottom).combined(with: .opacity)
        }
    }
}
