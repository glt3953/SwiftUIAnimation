//
//  TimerRingView.swift
//  SwiftUIAnimation
//
//  Created by 宁侠 on 2025/4/15.
//

import SwiftUI

struct TimerRingView: View {
    @State private var progress: CGFloat = 0.0
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("环形计时器动画")
                .font(.title)
                .padding(.top)
            
            // 环形计时器
            TimerRing(progress: progress)
                .frame(width: 250, height: 250)
                .padding(30)
            
            // 控制按钮
            HStack(spacing: 30) {
                Button("开始") {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        progress = 1.0
                    }
                }
                .buttonStyle(.bordered)
                
                Button("重置") {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        progress = 0.0
                    }
                }
                .buttonStyle(.bordered)
            }
            
            // 进度调整滑块
            VStack {
                Text("手动调整进度: \(Int(progress * 100))%")
                Slider(value: $progress, in: 0...1)
                    .padding(.horizontal)
            }
            .padding()
            
            // 自动循环动画按钮
            Button(isAnimating ? "停止循环" : "自动循环") {
                isAnimating.toggle()
                if isAnimating {
                    startLoopingAnimation()
                }
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
        .navigationTitle("环形计时器")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // 循环动画
    private func startLoopingAnimation() {
        // 重置进度
        withAnimation(.easeOut(duration: 0.5)) {
            progress = 0.0
        }
        
        // 延迟后开始动画
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            if isAnimating {
                withAnimation(.easeInOut(duration: 3.0)) {
                    progress = 1.0
                }
                
                // 完成后再次调用
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    if isAnimating {
                        startLoopingAnimation()
                    }
                }
            }
        }
    }
}

// 环形计时器组件
struct TimerRing: View {
    @Binding var progress: CGFloat
    
    // 如果使用初始化方法而不是@Binding
    init(progress: CGFloat) {
        self._progress = .constant(progress)
    }
    
    // 使用@Binding时的初始化方法
    init(progress: Binding<CGFloat>) {
        self._progress = progress
    }
    
    var body: some View {
        ZStack {
            // 中间的图标（替代Playtime图片）
            Image(systemName: "timer")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .scaleEffect(0.8)
            
            // 底层圆环
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 25, lineCap: .round))
                .opacity(0.1)
            
            // 进度圆环
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    style: StrokeStyle(lineWidth: 25, lineCap: .round)
                )
                .foregroundStyle(displayColor)
                .rotationEffect(.degrees(-90))
        }
    }
    
    // 根据进度变化颜色
    private var displayColor: Color {
        if progress < 0.3 {
            return .blue
        } else if progress < 0.7 {
            return .green
        } else {
            return .orange
        }
    }
}

// 预览
#Preview {
    NavigationView {
        TimerRingView()
    }
} 