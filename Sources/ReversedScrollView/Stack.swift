//
//  Stack.swift
//  ReversedScrollView
//
//  Created by Bri on 12/30/21.
//

import SwiftUI

public struct Stack<Content: View>: View {
    
    fileprivate var axis: Axis.Set
    fileprivate var content: Content
    
    public init(_ axis: Axis.Set = .vertical, @ViewBuilder builder: () -> Content) {
        self.axis = axis
        self.content = builder()
    }
    
    public var body: some View {
        switch axis {
        case .horizontal:
            HStack {
                content
            }
        case .vertical:
            VStack {
                content
            }
        default:
            VStack {
                content
            }
        }
    }
}

extension Stack where Content == EmptyView {
    public init(
        _ axis: Axis.Set = .vertical,
        @ViewBuilder builder: () -> Content = { EmptyView() }
    ) {
        self.axis = axis
        self.content = builder()
    }
}

fileprivate struct Stack_Previews: PreviewProvider {
    static var previews: some View {
        Stack(.vertical) {
            Stack(.horizontal)
        }
    }
}
