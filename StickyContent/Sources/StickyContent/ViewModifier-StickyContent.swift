//
//  ViewModifier-StickyContent.swift
//  StickyScroll
//
//  Created by Alex S. on 20/12/2022.
//

import SwiftUI

extension View {
  public func stickyContent(_ coordinateSpaceName: String) -> some View {
    self.modifier(
      StickyContentModifier(
        coordinateSpaceName: coordinateSpaceName
      )
    )
  }
}

struct StickyContentModifier: ViewModifier {
  let coordinateSpaceName: String
  @State private var frames: [CGRect] = []
  
  func body(content: Content) -> some View {
    content
      .onPreferenceChange(FramesPreference.self) { frames = $0 }
      .environment(\.stickyFrames, frames)
      .coordinateSpace(name: coordinateSpaceName)
  }
}

