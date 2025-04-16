//
//  ReflectionWaveformView.swift
//  SwiftUIAnimation
//
//  Created by 宁侠 on 2025/4/15.
//

import SwiftUI

struct ReflectionWaveformView: View {
    @State private var isAnimating = false
    @State private var showTranslation = true
    
    // 示例翻译文本
    let originalText = "How can I cook for you? Rare Well"
    let translatedText = "我可以为您推荐我们的招牌菜，我们这里的菜非常好吃，鱼不错，鸡肉不错，必须点的，如果你喜欢吃点辣的，可以来这个剁椒鱼头，您觉得如何？请您告诉我您喜欢哪些？"
    
    // 波形参数
    @State private var phase: CGFloat = 0
    @State private var secondPhase: CGFloat = 0
    @State private var thirdPhase: CGFloat = 0
    @State private var fourthPhase: CGFloat = 0
    
    var body: some View {
        ZStack {
            // 背景
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 标题栏
                HStack {
                    HStack(spacing: 5) {
                        Image(systemName: "waveform.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.purple)
                        
                        Text("八哥翻译")
                            .font(.headline)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Image(systemName: "square.on.square")
                        .font(.title3)
                        .padding()
                }
                
                Spacer()
                
                if !showTranslation {
                    // 语音提示文本
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
                } else {
                    // 翻译结果
                    VStack(alignment: .leading, spacing: 15) {
                        Text(originalText)
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.purple)
                            .cornerRadius(20)
                        
                        Text(translatedText)
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.purple)
                            .cornerRadius(20)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // 波形动画
                ZStack {
                    // 底层波浪 - 移动最慢，振幅最大
                    SmoothWaveform(phase: phase, amplitude: isAnimating ? 30 : 8, frequency: 0.1)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)),
                                    Color(#colorLiteral(red: 0.5568627715, green: 0.2666666806, blue: 0.6784313917, alpha: 1)),
                                    Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(height: 150)
                        .offset(y: 20)
                        .opacity(0.85)
                    
                    // 第二层波浪
                    SmoothWaveform(phase: secondPhase, amplitude: isAnimating ? 22 : 6, frequency: 0.13)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(#colorLiteral(red: 0.2196078449, green: 0.5882352948, blue: 0.8549019694, alpha: 1)),
                                    Color(#colorLiteral(red: 0.5568627715, green: 0.3215686334, blue: 0.7568627596, alpha: 1)),
                                    Color(#colorLiteral(red: 0.8039215803, green: 0.4392156899, blue: 0.5254902244, alpha: 1))
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(height: 150)
                        .offset(y: 20)
                        .opacity(0.7)
                    
                    // 第三层波浪
                    SmoothWaveform(phase: thirdPhase, amplitude: isAnimating ? 15 : 4, frequency: 0.17)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(#colorLiteral(red: 0.1215686277, green: 0.5882352948, blue: 1, alpha: 1)),
                                    Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)),
                                    Color(#colorLiteral(red: 0.5568627715, green: 0.4666666687, blue: 0.8980392157, alpha: 1))
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(height: 150)
                        .offset(y: 20)
                        .opacity(0.6)
                    
                    // 顶层波浪 - 移动最快，振幅较小
                    SmoothWaveform(phase: fourthPhase, amplitude: isAnimating ? 8 : 2, frequency: 0.22)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)),
                                    Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
                                    Color(#colorLiteral(red: 0.6078431606, green: 0.3450980484, blue: 0.8274509907, alpha: 1))
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(height: 150)
                        .offset(y: 20)
                        .opacity(0.5)
                }
                .frame(height: 180)
                .padding(.bottom, 40)
                .blur(radius: 0.5) // 轻微增加模糊，增强水波感
                
                // 停止按钮
                Button(action: {
                    isAnimating.toggle()
                    if !isAnimating {
                        showTranslation.toggle()
                    }
                }) {
                    Text("点击停止")
                        .foregroundColor(.secondary)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .background(Color.secondary.opacity(0.2))
                        .cornerRadius(20)
                }
                .padding(.bottom, 50)
            }
        }
        .navigationTitle("水中倒影波纹")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // 启动四层波浪动画，每层使用不同的动画参数
            withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                phase = .pi * 2
            }
            
            withAnimation(.linear(duration: 3.5).repeatForever(autoreverses: false)) {
                secondPhase = .pi * 2
            }
            
            withAnimation(.linear(duration: 2.5).repeatForever(autoreverses: false)) {
                thirdPhase = .pi * 2
            }
            
            withAnimation(.linear(duration: 1.8).repeatForever(autoreverses: false)) {
                fourthPhase = .pi * 2
            }
            
            // 2秒后启动音频波动
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeIn(duration: 0.5)) {
                    isAnimating = true
                }
            }
        }
    }
}

// 平滑波形
struct SmoothWaveform: Shape {
    var phase: CGFloat
    var amplitude: CGFloat
    var frequency: CGFloat
    
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let midHeight = height / 2
        let wavelength = width * frequency
        
        var path = Path()
        
        // 开始点
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        // 绘制上半部分波浪 - 使用更自然的波浪曲线
        for x in stride(from: 0, through: width, by: 1) {
            let angle = 2 * .pi * x / wavelength + phase
            
            // 使用多个正弦波叠加，创造更自然的波浪
            let primaryWave = sin(angle) * amplitude
            let secondaryWave = sin(angle * 1.8) * amplitude * 0.4
            let tertiaryWave = sin(angle * 3.2) * amplitude * 0.2
            
            // 添加微小随机扰动，增加自然感
            let random = sin(x/2.5) * amplitude * 0.07
            
            // 合成最终波形
            let y = midHeight - (primaryWave + secondaryWave + tertiaryWave + random)
            
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        // 连接到右下角，添加一点下沉效果
        path.addLine(to: CGPoint(x: width, y: midHeight + amplitude * 0.15))
        
        // 绘制下半部分波浪（水中倒影效果）
        for x in stride(from: width, through: 0, by: -1) {
            let angle = 2 * .pi * x / wavelength + phase
            
            // 使用与上部分类似但稍有不同的波形计算
            let primaryWave = sin(angle) * amplitude * 0.65 // 减小倒影的振幅
            let secondaryWave = sin(angle * 1.8) * amplitude * 0.25
            let tertiaryWave = sin(angle * 3.2) * amplitude * 0.15
            
            // 稍微增加随机性，模拟水下失真效果
            let random = sin(x/2) * amplitude * 0.1
            
            // 合成最终波形，并增加一点垂直偏移，模拟水下效果
            let y = midHeight + (primaryWave + secondaryWave + tertiaryWave + random) + amplitude * 0.2
            
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        // 关闭路径
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    NavigationView {
        ReflectionWaveformView()
    }
} 