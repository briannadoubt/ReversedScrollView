//
//  ReversedScrollView.swift
//  ReversedScrollView
//
//  Created by Brianna Zamora on 9/14/21.
//

import SwiftUI

public struct ReversedScrollView<Content: View>: View {
    
    fileprivate var axis: Axis.Set
    fileprivate var showsIndicator: Bool
    fileprivate var leadingSpace: CGFloat
    
    @ViewBuilder fileprivate var content: () -> Content
    
    public init(
        _ axis: Axis.Set = .vertical,
        showsIndicator: Bool = false,
        leadingSpace: CGFloat = 10,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axis = axis
        self.showsIndicator = showsIndicator
        self.leadingSpace = leadingSpace
        self.content = content
    }
    
    fileprivate func minWidth(in proxy: GeometryProxy, for axis: Axis.Set) -> CGFloat? {
       axis.contains(.horizontal) ? proxy.size.width : nil
    }
        
    fileprivate func minHeight(in proxy: GeometryProxy, for axis: Axis.Set) -> CGFloat? {
       axis.contains(.vertical) ? proxy.size.height : nil
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ScrollView(axis, showsIndicators: showsIndicator) {
                Stack(axis) {
                    Spacer(minLength: leadingSpace)
                    content()
                }
                .frame(
                   minWidth: minWidth(in: proxy, for: axis),
                   minHeight: minHeight(in: proxy, for: axis)
                )
            }
        }
    }
}

fileprivate struct ReversedScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ReversedScrollView(.vertical, leadingSpace: 50) {
            ForEach(0..<5) { item in
                Text("\(item)")
                    .padding()
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(6)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
