//
//  TestView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 21.08.23.
//

import SwiftUI
import PhotosUI

struct TestView: View {
    @State private var items = ["Item 1", "Item 2", "Item 3", "Item 4"]
    @State private var isDragging = false
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var offset: CGFloat = 0
    
    @State private var avatarItem: PhotosPickerItem?
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    PhotosPicker("Select avatar", selection: $avatarItem, matching: .images)
                    ForEach(1...50, id: \.self) { index in
                        Text("Item \(index)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        HStack(spacing: 0) {
                            ForEach(0..<letters.count, id: \.self) { num in
                                Text(String(letters[num]))
                                    .padding(5)
                                    .font(.title)
                                    .background(enabled ? .blue : .red)
                                    .offset(dragAmount)
                                    .animation(.default.delay(Double(num) / 20), value: dragAmount)
                            }
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { dragAmount = $0.translation }
                                .onEnded { _ in
                                    dragAmount = .zero
                                    enabled.toggle()
                                }
                        )
                        
                        Rectangle()
                                  .foregroundColor(Color.gray.opacity(0.3))
                                  .frame(height: 50)
                                  .offset(x: offset, y: 0)
                                  .gesture(
                                      DragGesture()
                                          .onChanged { value in
                                              if value.translation.width < 0 {
                                                  self.offset = value.translation.width
                                              }
                                          }
                                          .onEnded { value in
                                              withAnimation {
                                                  if -value.translation.width > 100 {
                                                      // Perform action when swipe is completed
                                                      self.offset = -200 // Move the view out of the screen
                                                  } else {
                                                      self.offset = 0 // Reset the offset
                                                  }
                                              }
                                          }
                                  )
                            
                    }
                }
                .padding()
            }
            .navigationTitle("Full Screen LazyVStack")
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

