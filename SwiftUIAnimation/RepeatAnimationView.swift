//
//  RepeatAnimationView.swift
//  SwiftUIAnimation
//
//  Created by 宁侠 on 2025/4/15.
//

import SwiftUI

struct RepeatAnimationView: View {
    @State private var isAnimating = false
    @State private var isPulsing = false
    @State private var isRotating = false
    @State private var isWaving = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("重复动画效果")
                .font(.title)
                .padding(.top)
            
            // 呼吸灯效果
            VStack {
                Text("脉冲效果")
                    .font(.headline)
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                    .scaleEffect(isPulsing ? 1.2 : 0.8)
                    .opacity(isPulsing ? 1.0 : 0.6)
                    .animation(isPulsing ? 
                        Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true) : .default, 
                        value: isPulsing)
                
                Button(isPulsing ? "停止" : "开始") {
                    isPulsing.toggle()
                }
                .buttonStyle(.bordered)
                .padding(.top, 10)
            }
            .padding()
            
            // 旋转效果
            VStack {
                Text("旋转效果")
                    .font(.headline)
                
                Image(systemName: "arrow.clockwise.circle")
                    .font(.system(size: 50))
                    .rotationEffect(.degrees(isRotating ? 360 : 0))
                    .animation(isRotating ? 
                        Animation.linear(duration: 2.0).repeatForever(autoreverses: false) : .default, 
                        value: isRotating)
                
                Button(isRotating ? "停止" : "开始") {
                    isRotating.toggle()
                }
                .buttonStyle(.bordered)
                .padding(.top, 10)
            }
            .padding()
            
            // 波浪效果
            VStack {
                Text("波浪效果")
                    .font(.headline)
                
                HStack(spacing: 10) {
                    ForEach(0..<5) { index in
                        Capsule()
                            .fill(Color.blue)
                            .frame(width: 20, height: 60)
                            .offset(y: isWaving ? -20 : 0)
                            .animation(isWaving ? 
                                Animation.easeInOut(duration: 0.5)
                                    .repeatForever(autoreverses: true)
                                    .delay(0.1 * Double(index)) : .default, 
                                value: isWaving)
                    }
                }
                
                Button(isWaving ? "停止" : "开始") {
                    isWaving.toggle()
                }
                .buttonStyle(.bordered)
                .padding(.top, 10)
            }
            .padding()
            
            // 所有效果开关
            Button(isAnimating ? "停止所有动画" : "启动所有动画") {
                isAnimating.toggle()
                isPulsing = isAnimating
                isRotating = isAnimating
                isWaving = isAnimating
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
        .navigationTitle("重复动画")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // 初次加载时展示动画效果
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    isAnimating = true
                    isPulsing = true
                    isRotating = true
                    isWaving = true
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        RepeatAnimationView()
    }
} 