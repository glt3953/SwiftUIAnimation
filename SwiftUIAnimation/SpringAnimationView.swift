//
//  SpringAnimationView.swift
//  SwiftUIAnimation
//
//  Created by 宁侠 on 2025/4/15.
//

import SwiftUI

struct SpringAnimationView: View {
    @State private var position: CGFloat = 0
    @State private var scale: CGFloat = 1.0
    @State private var dampingFraction: Double = 0.5
    @State private var stiffness: Double = 100
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("弹簧动画效果")
                    .font(.title)
                    .padding(.top)
                
                // 弹簧效果的方块
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: 300, height: 300)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue)
                        .frame(width: 80, height: 80)
                        .offset(y: position)
                        .scaleEffect(scale)
                }
                .padding()
                
                VStack(spacing: 10) {
                    Text("阻尼系数: \(dampingFraction, specifier: "%.2f")")
                    Slider(value: $dampingFraction, in: 0.1...1.0)
                        .padding(.horizontal)
                    
                    Text("刚度: \(stiffness, specifier: "%.0f")")
                    Slider(value: $stiffness, in: 50...300)
                        .padding(.horizontal)
                }
                .padding()
                
                HStack(spacing: 20) {
                    Button("弹跳") {
                        position = 0
                        withAnimation(.interpolatingSpring(stiffness: stiffness, damping: 5)) {
                            position = 100
                        }
                    }
                    .buttonStyle(.bordered)
                    
                    Button("缩放") {
                        scale = 1.0
                        withAnimation(.spring(response: 0.5, dampingFraction: dampingFraction)) {
                            scale = 1.3
                        }
                    }
                    .buttonStyle(.bordered)
                    
                    Button("复位") {
                        withAnimation(.spring(response: 0.5, dampingFraction: dampingFraction)) {
                            position = 0
                            scale = 1.0
                        }
                    }
                    .buttonStyle(.bordered)
                }
                
                Text("说明")
                    .font(.headline)
                    .padding(.top)
                
                Text("• 阻尼系数(dampingFraction)：控制振动幅度的衰减速度，数值越小，振动越明显\n• 刚度(stiffness)：控制弹性强度，数值越大，弹力越强\n• 响应时间(response)：控制动画完成的时间，数值越小，动画越快\n• 质量(mass)：控制物体的惯性，数值越大，动画越迟缓\n• 初始速度(initialVelocity)：控制动画开始时的速度，正值表示向动画方向加速，负值表示初始反向运动")
                    .font(.caption)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
            .padding()
        }
        .navigationTitle("弹簧动画")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        SpringAnimationView()
    }
} 