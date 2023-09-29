//
//  TabView.swift
//  StickyScroll
//
//  Created by Alex S. on 20/12/2022.
//

import SwiftUI

enum Section: String, Hashable, CaseIterable, Identifiable {
  case first, second
  
  var id: Self { self }
}

struct ColorItem: Identifiable {
  let id = UUID()
  let color = Color(hue: CGFloat.random(in: 0...1), saturation: 0.3, brightness: 1, opacity: 1)
}

struct ColorsView: View {
  @State private var section = Section.first
  @State private var offsets: [Section : CGFloat] = [:]
  
  let items1 = (0...50).map { _ in ColorItem() }
  let items2 = (0...100).map { _ in ColorItem() }
  let columns: [GridItem] = [.init(.adaptive(minimum: 100))]
  
  var body: some View {
    VStack {
      Picker("section", selection: $section) {
        ForEach(Section.allCases) { section in
          Text(section.rawValue.capitalized)
        }
      }
      .padding(.horizontal)
      .pickerStyle(.segmented)
      
      ScrollView {
        LazyVGrid(columns: columns) {
          ForEach(section == .first ? items1 : items2) { item in
            item.color
              .aspectRatio(1, contentMode: .fit)
              .cornerRadius(4)
          }
        }
        .padding()
        .scrollOffset(in: "scroll") { value in
          offsets[section] = value
        }
      }
      .coordinateSpace(name: "scroll")
      .overlay(alignment: .center) {
        Text(verbatim: "\(offsets.mapValues { Int($0) })")
          .foregroundColor(.white)
          .padding(4)
          .background(.black)
          .padding()
      }
    }
  }
}

extension View {
  func scrollOffset(
    in coordinateSpace: String,
    perform: @escaping (CGFloat) -> ()
  ) -> some View {
    self.overlay(alignment: .top) {
      GeometryReader { proxy in
        let offset = proxy.frame(
          in: CoordinateSpace.named(coordinateSpace)).minY
        Color.clear
          .onAppear { perform(offset) }
          .onChange(of: offset, perform: perform)
      }
    }
  }
}

#Preview {
  NavigationStack {
    ColorsView()
      .navigationTitle("Colors")
  }
}
