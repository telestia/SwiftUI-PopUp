//
//  PopUpModifier.swift
//  Video Downloader
//
//  Created by Harun SUBAŞI on 12.08.2025.
//

import SwiftUI

public struct PopUpModifier<PopupContent: View>: ViewModifier {
    @Binding var isPresented: Bool

    let position: PopUpPosition
    let dismissOnTapOutside: Bool
    let dimOpacity: Double
    let autoDismissAfter: TimeInterval?
    let animation: Animation
    let ignoresSafeArea: Bool

    @ViewBuilder let popupContent: () -> PopupContent

    @State private var didAppearOnce = false

    public func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content

            if isPresented {
                // Dim
                Color.black.opacity(dimOpacity)
                    .ignoresSafeArea(ignoresSafeArea ? .all : [])
                    .onTapGesture {
                        if dismissOnTapOutside {
                            withAnimation(animation) { isPresented = false }
                        }
                    }
                    .transition(.opacity)
                    .zIndex(1)

                // Popup
                ZStack {
                    popupContent()
                        .accessibilityAddTraits(.isModal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: position.alignment)
                .padding(.horizontal, 16)
                .padding(.vertical, position == .center ? 0 : 24)
                .transition(position.transition)
                .zIndex(2)
            }
        }
        .animation(animation, value: isPresented)
        .onChange(of: isPresented) {
            guard isPresented, let delay = autoDismissAfter else { return }
            // Auto-dismiss
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if isPresented {
                    withAnimation(animation) { isPresented = false }
                }
            }
        }
    }
}

extension View {
    public func popUp<PopupContent: View>(
        isPresented: Binding<Bool>,
        position: PopUpPosition = .center,
        dismissOnTapOutside: Bool = true,
        dimOpacity: Double = 0.5,
        autoDismissAfter: TimeInterval? = nil,
        animation: Animation = .spring(response: 0.3, dampingFraction: 0.85),
        ignoresSafeArea: Bool = true,
        @ViewBuilder content: @escaping () -> PopupContent
    ) -> some View {
        self.modifier(
            PopUpModifier(
                isPresented: isPresented,
                position: position,
                dismissOnTapOutside: dismissOnTapOutside,
                dimOpacity: dimOpacity,
                autoDismissAfter: autoDismissAfter,
                animation: animation,
                ignoresSafeArea: ignoresSafeArea,
                popupContent: content
            )
        )
    }
}
