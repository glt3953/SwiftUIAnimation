//
//  ExactTimerRingView.swift
//  SwiftUIAnimation
//
//  Created by 宁侠 on 2025/4/15.
//

import SwiftUI

struct ExactTimerRingView: View {
    @State private var progress: CGFloat = 0.3
    @State private var animating = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("精确环形计时器")
                .font(.title)
                .padding(.top)
            
            ExactTimerRing(progress: $progress)
                .frame(width: 280, height: 280)
                .padding(20)
            
            // 控制按钮
            HStack(spacing: 30) {
                Button("增加进度") {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        progress = min(1.0, progress + 0.1)
                    }
                }
                .buttonStyle(.bordered)
                
                Button("减少进度") {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        progress = max(0.0, progress - 0.1)
                    }
                }
                .buttonStyle(.bordered)
            }
            
            // 自动动画
            Button(animating ? "停止动画" : "开始动画") {
                animating.toggle()
                
                if animating {
                    withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                        progress = 1.0
                    }
                } else {
                    withAnimation(.easeInOut) {
                        progress = 0.3
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 20)
            
            Text("实现说明")
                .font(.headline)
                .padding(.top, 20)
            
            Text("此视图基于图片中的代码实现，使用了Circle、trim、stroke等组件构建环形进度条，并使用精确的角度和样式参数。")
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationTitle("精确环形计时器")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExactTimerRing: View {
    @Binding var progress: CGFloat
    
    // 设计参数
    let lineWidth: CGFloat = 25
    let displayColor: Color = .blue
    
    var body: some View {
        ZStack {
            // 中央图标 - 使用系统图标替代Playtime图片
            ZStack {
                Image(systemName: "timer")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.55)
            }
            .foregroundStyle(displayColor)
            .padding()
            
            // 外部透明圆环
            Circle()
                .stroke(
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .opacity(0.1)
            
            // 进度圆环
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .foregroundStyle(displayColor)
                .rotationEffect(.degrees(-90))
        }
        .padding()
    }
}

// 直接实现图片中的代码
struct ExactTimerRingOriginal: View {
    @Binding var progress: CGFloat
    
    var body: some View {
        ZStack {
            Image(systemName: "timer")  // 使用系统图标代替"Playtime"
                .resizable()
                .scaledToFit()
                .scaleEffect(0.55)
            
            Circle()
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 25,
                        lineCap: .round
                    )
                )
                .opacity(0.1)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 25,
                        lineCap: .round
                    )
                )
                .foregroundStyle(Color.blue)
                .rotationEffect(.degrees(-90))
        }
        .foregroundStyle(Color.blue)
        .padding()
    }
}

#Preview {
    NavigationView {
        ExactTimerRingView()
    }
} 