//
//  ContentView.swift
//  StickyScroll
//
//  Created by Alex S. on 20/12/2022.
//

import SwiftUI
import StickyContent

struct LoremSectionsView: View {
  var body: some View {
    ScrollView {
      ForEach(1..<10) { row in
        VStack {
          HStack {
            Text("Section \(row)")
              .font(.headline)
            Spacer()
            Text("\(10) words")
              .font(.caption)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
          .frame(height: 50)
          .background(.thinMaterial)
          .sticky(in: "scroll")
          
          Text(section)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
      }
    }
    .stickyContent("scroll")
    .safeAreaInset(edge: .bottom) {
      Text("Total sections: 9")
        .font(.subheadline)
        .frame(maxWidth: .infinity)
        .padding(.top, 8)
        .background(.regularMaterial)
    }
  }
  
  private var section: String {
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut turpis tempor, porta diam ut, iaculis leo. Phasellus condimentum euismod enim fringilla vulputate. Suspendisse sed quam mattis, suscipit ipsum vel, volutpat quam. Donec sagittis felis nec nulla viverra, et interdum enim sagittis. Nunc egestas scelerisque enim ac feugiat."
      .split(separator: ".")
      .shuffled()
      .dropLast(Int.random(in: 1...4))
      .joined(separator: " ")
      .dropFirst()
      .lowercased()
  }
}

#Preview {
  NavigationView {
    LoremSectionsView()
      .navigationTitle("Lorem ipsum")
  }
}
