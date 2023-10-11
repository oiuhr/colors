//
//  ContentView.swift
//  colors
//
//  Created by oiu on 12.10.2023.
//

import SwiftUI

extension CGPoint: AdditiveArithmetic {
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

struct ContentView: View {
    
    enum Constants {
        static var edge: CGFloat = 100
        static var basePosition = CGPoint(
            x: edge / 2,
            y: edge / 2
        )
    }
    
    @State
    private var position = Constants.basePosition
    @State
    private var touchOffset: CGPoint? = nil
    
    var rectangle: some View {
        RoundedRectangle(cornerRadius: 10)
            .position(position)
            .frame(
                width: Constants.edge,
                height: Constants.edge
            )
            .gesture(gesture)
    }
    
    var gesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                if touchOffset == nil {
                    touchOffset = value.location
                }
                position = value.location - (touchOffset ?? .zero) + Constants.basePosition
            }
            .onEnded { value in
                touchOffset = nil
                withAnimation {
                    position = Constants.basePosition
                }
            }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.white
                Color.pink
                Color.yellow
                Color.black
            }
            rectangle
                .foregroundColor(.white)
                .blendMode(.difference)
                .overlay(rectangle.blendMode(.color))
                .overlay(rectangle.foregroundColor(.white).blendMode(.overlay))
                .overlay(rectangle.foregroundColor(.black).blendMode(.overlay))
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
