//
//  ViewModifier-Sticky.swift
//  StickyScroll
//
//  Created by Alex S. on 20/12/2022.
//

import SwiftUI

extension View {
  public func sticky(in coordinateSpaceName: String) -> some View {
    self.modifier(
      StickyFrameModifier(
        coordinateSpaceName: coordinateSpaceName
      )
    )
  }
}

struct StickyFrameModifier: ViewModifier {
  let coordinateSpaceName: String
  
  @Environment(\.stickyFrames) var frames
  @State private var frame = CGRect.zero
  
  var isSticky: Bool {
    frame.minY < 0
  }
  
  var offset: CGFloat {
    guard isSticky else { return 0 }
    
    // header sticks on top
    var y = -frame.minY
    
    /// current header is pushed up by the other header
    if let index = frames.firstIndex(where: { ($0.minY > frame.minY) && ($0.minY < frame.height) }) {
      let other = frames[index]
      y -= frame.height - other.minY
    }
    
    return y
  }
  
  func body(content: Content) -> some View {
    content
      .offset(y: offset)
      .zIndex(isSticky ? .infinity : 0)
      .overlay(
        GeometryReader { proxy in
          let rect = proxy.frame(in: .named(coordinateSpaceName))
          Color.clear
            .onAppear { frame = rect }
            .onChange(of: rect) { frame = $0 }
            .preference(key: FramesPreference.self, value: [frame])
        }
      )
  }
}
