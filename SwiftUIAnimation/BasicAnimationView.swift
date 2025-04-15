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
        ScrollView {
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
                
                // 添加额外的颜色动画示例
                VStack {
                    Text("颜色变化")
                        .font(.headline)
                    
                    ColorChangeView()
                        .frame(width: 100, height: 100)
                        .padding()
                }
                
                // 添加路径动画示例
                VStack {
                    Text("路径变形")
                        .font(.headline)
                    
                    PathMorphView()
                        .frame(width: 120, height: 120)
                        .padding()
                }
                
                // 文本动画
                VStack {
                    Text("文本动画")
                        .font(.headline)
                    
                    TextAnimationView()
                        .padding()
                }
                
                Spacer()
                    .frame(height: 40)
            }
            .padding()
        }
        .navigationTitle("基础动画")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 颜色渐变动画
struct ColorChangeView: View {
    @State private var changeColor = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(changeColor ? Color.red : Color.blue)
            .overlay(
                Button("变色") {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        changeColor.toggle()
                    }
                }
                .foregroundColor(.white)
            )
    }
}

// 路径变形动画
struct PathMorphView: View {
    @State private var morphed = false
    
    var body: some View {
        VStack {
            if morphed {
                Circle()
                    .fill(Color.green)
                    .transition(.opacity.combined(with: .scale))
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.yellow)
                    .transition(.opacity.combined(with: .scale))
            }
        }
        .frame(width: 100, height: 100)
        .overlay(
            Button("变形") {
                withAnimation {
                    morphed.toggle()
                }
            }
            .foregroundColor(.black)
        )
    }
}

// 文本动画
struct TextAnimationView: View {
    @State private var fontSize: CGFloat = 16
    @State private var textRotation: Double = 0
    
    var body: some View {
        VStack {
            Text("SwiftUI 动画")
                .font(.system(size: fontSize))
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .lineLimit(1)     // 限制为单行文本
                .fixedSize()      // 根据内容而非容器调整大小
                .frame(minWidth: 150, minHeight: 50)  // 保证有足够空间容纳放大的文本
                .rotationEffect(.degrees(textRotation))
                .padding()
                .onTapGesture {
                    withAnimation(.spring()) {
                        fontSize = fontSize == 16 ? 30 : 16
                        textRotation = textRotation == 0 ? 360 : 0
                    }
                }
            
            Text("点击文本")
                .font(.caption)
        }
    }
}

#Preview {
    NavigationView {
        BasicAnimationView()
    }
} 