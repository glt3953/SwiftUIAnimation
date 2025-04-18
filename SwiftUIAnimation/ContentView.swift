//
//  ContentView.swift
//  SwiftUIAnimation
//
//  Created by 宁侠 on 2025/4/15.
//

import SwiftUI

struct ContentView: View {
    // 动画示例列表
    var animations: [(String, String, AnyView)] {
        [
            ("基础动画", "基本的SwiftUI动画效果", AnyView(BasicAnimationView())),
            ("弹簧动画", "使用spring效果的动画", AnyView(SpringAnimationView())),
            ("重复动画", "循环重复的动画效果", AnyView(RepeatAnimationView())),
            ("渐变过渡", "组件之间的过渡效果", AnyView(TransitionAnimationView())),
            ("手势动画", "基于手势的交互动画", AnyView(GestureAnimationView())),
            ("组合动画", "复杂的组合动画效果", AnyView(CombinedAnimationView())),
            ("环形计时器", "进度环形动画效果", AnyView(TimerRingView())),
            ("精确计时器", "按图片代码实现的环形计时器", AnyView(ExactTimerRingView())),
            ("音频波纹", "语音识别波形动画效果", AnyView(AudioWaveformView())),
            ("翻译波浪", "水中倒影样式的波浪动效", AnyView(ReflectionWaveformView()))
        ]
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<animations.count, id: \.self) { index in
                    let (title, description, destination) = animations[index]
                    NavigationLink(destination: destination) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(title)
                                .font(.headline)
                            Text(description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("SwiftUI 动画效果")
        }
    }
}

#Preview {
    ContentView()
}
