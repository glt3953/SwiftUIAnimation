//
//  CombinedAnimationView.swift
//  SwiftUIAnimation
//
//  Created by 宁侠 on 2025/4/15.
//

import SwiftUI

struct CombinedAnimationView: View {
    // 动画控制状态
    @State private var isAnimating = false
    @State private var showingLoader = false
    @State private var showingNotification = false
    @State private var progress: CGFloat = 0.0
    
    // 计时器
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    // 渐变色
    let gradientColors = [Color.blue, Color.purple, Color.pink]
    
    var body: some View {
        VStack(spacing: 30) {
            Text("组合动画效果")
                .font(.title)
                .padding(.top)
            
            // 加载动画组
            VStack {
                Text("自定义加载动画")
                    .font(.headline)
                
                if showingLoader {
                    LoaderView()
                        .frame(width: 100, height: 100)
                        .transition(.opacity.combined(with: .scale))
                }
                
                Button(showingLoader ? "隐藏加载器" : "显示加载器") {
                    withAnimation(.spring()) {
                        showingLoader.toggle()
                    }
                }
                .buttonStyle(.bordered)
                .padding(.top, 10)
            }
            .padding()
            
            // 进度条动画
            VStack {
                Text("进度条动画")
                    .font(.headline)
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 20)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: gradientColors),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: UIScreen.main.bounds.width * 0.8 * progress, height: 20)
                }
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .padding()
                
                HStack {
                    Button("重置") {
                        withAnimation(.easeOut(duration: 0.3)) {
                            progress = 0
                        }
                    }
                    .buttonStyle(.bordered)
                    
                    Button("加载") {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            progress = 1.0
                        }
                    }
                    .buttonStyle(.bordered)
                    
                    Button("步进") {
                        withAnimation(.spring()) {
                            progress = min(1.0, progress + 0.2)
                        }
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            
            // 卡片翻转动画
            FlipCardView()
                .frame(height: 200)
                .padding(.horizontal)
            
            // 按钮动画
            AnimatedButton(title: "动感按钮") {
                // 点击按钮后的操作
                withAnimation(.spring()) {
                    showingNotification = true
                }
                
                // 3秒后关闭通知
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.easeOut) {
                        showingNotification = false
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("组合动画")
        .navigationBarTitleDisplayMode(.inline)
        .overlay(
            // 顶部通知
            ZStack {
                if showingNotification {
                    VStack {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                            
                            Text("操作成功！")
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    showingNotification = false
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .frame(maxWidth: .infinity, alignment: .top)
                }
            }
        )
    }
}

// 自定义加载动画组件
struct LoaderView: View {
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.blue.opacity(0.3), lineWidth: 10)
            
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: rotation))
                .onAppear {
                    withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                        rotation = 360
                    }
                }
        }
    }
}

// 卡片翻转动画
struct FlipCardView: View {
    @State private var isFlipped = false
    @State private var degrees: Double = 0
    
    var body: some View {
        VStack {
            Text("卡片翻转")
                .font(.headline)
            
            ZStack {
                // 卡片正面
                CardFrontView()
                    .opacity(isFlipped ? 0 : 1)
                    .rotation3DEffect(
                        .degrees(degrees),
                        axis: (x: 0, y: 1, z: 0)
                    )
                
                // 卡片背面
                CardBackView()
                    .opacity(isFlipped ? 1 : 0)
                    .rotation3DEffect(
                        .degrees(degrees - 180),
                        axis: (x: 0, y: 1, z: 0)
                    )
            }
            
            Button("翻转卡片") {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                    degrees += 180
                    isFlipped.toggle()
                }
            }
            .buttonStyle(.bordered)
            .padding(.top, 10)
        }
    }
}

// 卡片正面
struct CardFrontView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            VStack {
                Text("正面")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                Image(systemName: "star.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.yellow)
                    .padding()
            }
        }
    }
}

// 卡片背面
struct CardBackView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(
                        colors: [.orange, .red],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            VStack {
                Text("背面")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                Image(systemName: "moon.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.yellow)
                    .padding()
            }
        }
    }
}

// 动感按钮
struct AnimatedButton: View {
    var title: String
    var action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            isPressed = true
            
            // 执行动作
            action()
            
            // 短暂延迟后恢复按钮状态
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.spring()) {
                    isPressed = false
                }
            }
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                .padding(.vertical, 15)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
                .shadow(color: .blue.opacity(0.5), radius: isPressed ? 2 : 8, x: 0, y: isPressed ? 1 : 4)
                .scaleEffect(isPressed ? 0.95 : 1)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NavigationView {
        CombinedAnimationView()
    }
} 