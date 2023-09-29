//
//  StickyScrollApp.swift
//  StickyScroll
//
//  Created by Alex S. on 20/12/2022.
//

import SwiftUI

@main
struct StickyScrollApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationView {
        LoremSectionsView()
          .navigationTitle("Lorem ipsum")
      }
    }
  }
}
