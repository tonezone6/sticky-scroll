//
//  EnvironmentKey-StickyFrames.swift
//  StickyScroll
//
//  Created by Alex S. on 20/12/2022.
//

import SwiftUI

enum StickyFrames: EnvironmentKey {
  static var defaultValue: [CGRect] = []
}

extension EnvironmentValues {
  var stickyFrames: [CGRect] {
    get { self[StickyFrames.self] }
    set { self[StickyFrames.self] = newValue }
  }
}
