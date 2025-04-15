//
//  BasicAnimationView.swift
//  SwiftUIAnimation
//
//  Created by 宁侠 on 2025/4/15.
//

import SwiftUI

struct BasicAnimationView: View {
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Double = 0
    @State private var opacity: Double = 1.0
    @State private var offset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("基础动画效果")
                .font(.title)
                .padding(.top)
            
            // 缩放动画
            VStack {
                Text("缩放")
                    .font(.headline)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(width: 100, height: 100)
                    .scaleEffect(scale)
                    .padding()
                
                Button("缩放动画") {
                    withAnimation(.easeInOut(duration: 1)) {
                        scale = scale == 1.0 ? 1.5 : 1.0
                    }
                }
                .buttonStyle(.bordered)
            }
            
            // 旋转动画
            VStack {
                Text("旋转")
                    .font(.headline)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.green)
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(rotation))
                    .padding()
                
                Button("旋转动画") {
                    withAnimation(.easeInOut(duration: 1)) {
                        rotation += 90
                    }
                }
                .buttonStyle(.bordered)
            }
            
            // 透明度动画
            VStack {
                Text("透明度")
                    .font(.headline)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.orange)
                    .frame(width: 100, height: 100)
                    .opacity(opacity)
                    .padding()
                
                Button("透明度动画") {
                    withAnimation(.easeInOut(duration: 1)) {
                        opacity = opacity == 1.0 ? 0.2 : 1.0
                    }
                }
                .buttonStyle(.bordered)
            }
            
            // 位移动画
            VStack {
                Text("位移")
                    .font(.headline)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.purple)
                    .frame(width: 100, height: 100)
                    .offset(x: offset)
                    .padding()
                
                Button("位移动画") {
                    withAnimation(.easeInOut(duration: 1)) {
                        offset = offset == 0 ? 100 : 0
                    }
                }
                .buttonStyle(.bordered)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("基础动画")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        BasicAnimationView()
    }
} 