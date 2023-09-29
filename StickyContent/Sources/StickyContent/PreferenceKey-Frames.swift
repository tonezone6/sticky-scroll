//
//  View-Sticky.swift
//  StickyScroll
//
//  Created by Alex S. on 20/12/2022.
//

import SwiftUI

struct FramesPreference: PreferenceKey {
  static var defaultValue: [CGRect] = []
  
  static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
    value.append(contentsOf: nextValue())
  }
}

