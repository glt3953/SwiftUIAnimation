//
//  AudioWaveformView.swift
//  SwiftUIAnimation
//
//  Created by 宁侠 on 2025/4/15.
//

import SwiftUI
import UIKit  // 导入UIKit以使用UIColor

struct AudioWaveformView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("音频波纹动效")
                .font(.title)
                .padding(.top)
            
            Spacer()
            
            // 主要波纹动画
            ZStack {
                // 背景渐变效果
                LinearGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.9333333373, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.7803921699, blue: 0.9882352941, alpha: 1))]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .opacity(0.2)
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // 提示文本
                    VStack(spacing: 10) {
                        Text("Please speak,")
                            .font(.system(size: 40, weight: .bold))
                        
                        Text("I'm listening")
                            .font(.system(size: 40, weight: .bold))
                        
                        Text("请说话，我在听")
                            .font(.system(size: 20))
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 200)
                    
                    Spacer()
                    
                    // 波形动画
                    WaveformView(isAnimating: isAnimating)
                        .frame(height: 100)
                        .padding(.bottom, 40)
                    
                    // 控制按钮
                    Button(isAnimating ? "点击停止" : "点击开始") {
                        isAnimating.toggle()
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 30)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(20)
                    .padding(.bottom, 40)
                }
            }
            
            Spacer()
        }
        .navigationTitle("音频波纹")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 波形视图组件
struct WaveformView: View {
    var isAnimating: Bool
    private let numberOfBars = 30
    private let minHeight: CGFloat = 3
    private let maxHeight: CGFloat = 40
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<numberOfBars, id: \.self) { index in
                WaveBar(index: index, isAnimating: isAnimating, minHeight: minHeight, maxHeight: maxHeight)
            }
        }
    }
}

// 单个波形条
struct WaveBar: View {
    let index: Int
    var isAnimating: Bool
    let minHeight: CGFloat
    let maxHeight: CGFloat
    
    @State private var height: CGFloat = 5
    
    // 每个条形的颜色会略有不同，创建渐变效果
    private var barColors: [Color] {
        // 从左到右的渐变色
        let colors: [Color] = [
            Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)),
            Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),
            Color(#colorLiteral(red: 0.5568627715, green: 0.3215686334, blue: 0.9686274529, alpha: 1))
        ]
        
        // 根据索引位置确定颜色混合
        let factor = Double(index) / Double(30)
        if factor < 0.5 {
            let mixFactor = factor * 2
            return [Color.interpolate(colors[0], colors[1], factor: mixFactor)]
        } else {
            let mixFactor = (factor - 0.5) * 2
            return [Color.interpolate(colors[1], colors[2], factor: mixFactor)]
        }
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: barColors),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 4, height: height)
            .onAppear {
                // 初始随机高度
                height = CGFloat.random(in: minHeight...minHeight + 12)
                
                // 如果一开始就需要动画，延迟启动
                if isAnimating {
                    startAnimation()
                }
            }
            .onChange(of: isAnimating) {
                if isAnimating {
                    startAnimation()
                }
            }
    }
    
    private func startAnimation() {
        // 为每个条形设置略微不同的定时，使其看起来更自然
        let baseDelay = Double(index) * 0.05
        let randomDuration = Double.random(in: 0.5...1.0)
        
        withAnimation(
            Animation
                .easeInOut(duration: randomDuration)
                .repeatForever(autoreverses: true)
                .delay(baseDelay)
        ) {
            // 动态计算每个条的高度，使中间的条形更高
            let centerFactor = 1.0 - abs(Double(index - 15) / 15.0)
            let maxRandomHeight = minHeight + (maxHeight * centerFactor)
            height = CGFloat.random(in: minHeight...maxRandomHeight)
        }
    }
}

// 颜色插值扩展
extension Color {
    static func interpolate(_ color1: Color, _ color2: Color, factor: Double) -> Color {
        let factor = min(max(factor, 0), 1)
        
        // 使用UIColor提供的更精确的颜色混合
        guard let c1 = UIColor(color1).cgColor.components,
              let c2 = UIColor(color2).cgColor.components else {
            return factor < 0.5 ? color1 : color2 // 降级方案
        }
        
        // 获取颜色分量
        let r1 = c1[0]
        let g1 = c1[1]
        let b1 = c1[2]
        
        let r2 = c2[0]
        let g2 = c2[1]
        let b2 = c2[2]
        
        // 线性插值
        let r = r1 + (r2 - r1) * CGFloat(factor)
        let g = g1 + (g2 - g1) * CGFloat(factor)
        let b = b1 + (b2 - b1) * CGFloat(factor)
        
        // 创建新颜色
        return Color(UIColor(red: r, green: g, blue: b, alpha: 1.0))
    }
}

#Preview {
    NavigationView {
        AudioWaveformView()
    }
} 
