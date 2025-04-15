//
//  TransitionAnimationView.swift
//  SwiftUIAnimation
//
//  Created by 宁侠 on 2025/4/15.
//

import SwiftUI

struct TransitionAnimationView: View {
    @State private var showCard = false
    @State private var showModal = false
    @State private var showNotification = false
    @State private var selectedTransition = 0
    
    // 过渡动画类型
    let transitions = [
        AnyTransition.opacity.animation(.easeInOut(duration: 0.5)),
        AnyTransition.scale.animation(.spring(response: 0.5, dampingFraction: 0.6)),
        AnyTransition.slide.animation(.easeInOut(duration: 0.5)),
        AnyTransition.move(edge: .bottom).animation(.easeInOut(duration: 0.5)),
        AnyTransition.asymmetric(insertion: .slide, removal: .opacity).animation(.easeInOut(duration: 0.5))
    ]
    
    // 过渡动画名称
    let transitionNames = ["淡入淡出", "缩放", "滑动", "底部移入", "不对称过渡"]
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("过渡动画效果")
                    .font(.title)
                    .padding(.top)
                
                // 选择过渡类型
                Picker("过渡类型", selection: $selectedTransition) {
                    ForEach(0..<transitionNames.count, id: \.self) { index in
                        Text(transitionNames[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // 卡片过渡
                VStack {
                    Text("卡片过渡")
                        .font(.headline)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 150)
                        
                        if showCard {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                                .frame(height: 150)
                                .overlay(
                                    Text("卡片内容")
                                        .foregroundColor(.white)
                                )
                                .transition(transitions[selectedTransition])
                        }
                    }
                    .frame(height: 150)
                    .padding(.horizontal)
                    
                    Button(showCard ? "隐藏卡片" : "显示卡片") {
                        withAnimation {
                            showCard.toggle()
                        }
                    }
                    .buttonStyle(.bordered)
                    .padding(.top, 8)
                }
                .padding()
                
                // 通知过渡
                Button("显示通知") {
                    withAnimation {
                        showNotification = true
                    }
                    
                    // 3秒后自动消失
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            showNotification = false
                        }
                    }
                }
                .buttonStyle(.bordered)
                
                // 模态过渡
                Button("显示模态") {
                    withAnimation {
                        showModal = true
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .padding()
            
            // 通知提示
            if showNotification {
                VStack {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.white)
                            .padding(.leading)
                        
                        Text("这是一条通知消息")
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                showNotification = false
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .padding(.trailing)
                        }
                    }
                    .background(Color.green)
                    .cornerRadius(8)
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 8)
                .transition(transitions[selectedTransition])
            }
            
            // 模态视图
            if showModal {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showModal = false
                        }
                    }
                
                VStack {
                    Text("模态内容")
                        .font(.title2)
                        .padding()
                    
                    Text("点击背景关闭")
                        .foregroundColor(.secondary)
                    
                    Button("关闭") {
                        withAnimation {
                            showModal = false
                        }
                    }
                    .buttonStyle(.bordered)
                    .padding()
                }
                .frame(width: 300, height: 200)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
                .transition(transitions[selectedTransition])
            }
        }
        .navigationTitle("过渡动画")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        TransitionAnimationView()
    }
} 