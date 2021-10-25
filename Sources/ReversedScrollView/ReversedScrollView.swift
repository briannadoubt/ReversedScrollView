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
    fileprivate var content: Content
    fileprivate var proxy: GeometryProxy?
    
    public init(
        _ axis: Axis.Set = .vertical,
        showsIndicator: Bool = false,
        leadingSpace: CGFloat = 10,
        proxy: GeometryProxy? = nil,
        @ViewBuilder builder: () -> Content
    ) {
        self.axis = axis
        self.showsIndicator = showsIndicator
        self.leadingSpace = leadingSpace
        self.proxy = proxy
        self.content = builder()
    }
    
    fileprivate func minWidth(in proxy: GeometryProxy, for axis: Axis.Set) -> CGFloat? {
       axis.contains(.horizontal) ? proxy.size.width : nil
    }
        
    fileprivate func minHeight(in proxy: GeometryProxy, for axis: Axis.Set) -> CGFloat? {
       axis.contains(.vertical) ? proxy.size.height : nil
    }
    
    public var body: some View {
        
        if let proxy = proxy {
            ScrollView(axis, showsIndicators: showsIndicator) {
                Stack(axis) {
                    Spacer(minLength: leadingSpace)
                    content
                }
                .frame(
                   minWidth: minWidth(in: proxy, for: axis),
                   minHeight: minHeight(in: proxy, for: axis)
                )
            }
        } else {
            GeometryReader { proxy in
                ScrollView(axis, showsIndicators: showsIndicator) {
                    Stack(axis) {
                        Spacer(minLength: leadingSpace)
                        content
                    }
                    .frame(
                       minWidth: minWidth(in: proxy, for: axis),
                       minHeight: minHeight(in: proxy, for: axis)
                    )
                }
            }
        }
    }
}

struct ReversedScrollView_Previews: PreviewProvider {
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

public struct ViewOffsetKey: PreferenceKey {
    public typealias Value = CGFloat
    public static var defaultValue = CGFloat.zero
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

