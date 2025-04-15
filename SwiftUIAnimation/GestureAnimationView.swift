//
//  GestureAnimationView.swift
//  SwiftUIAnimation
//
//  Created by 宁侠 on 2025/4/15.
//

import SwiftUI

struct GestureAnimationView: View {
    // 拖拽卡片的状态
    @State private var dragOffset: CGSize = .zero
    @State private var isDragging = false
    
    // 缩放图片的状态
    @State private var scale: CGFloat = 1.0
    
    // 旋转按钮的状态
    @State private var rotationAngle: Double = 0
    
    // 可调整位置的方块状态
    @State private var position = CGPoint(x: 150, y: 150)
    
    var body: some View {
        VStack(spacing: 20) {
            Text("手势动画效果")
                .font(.title)
                .padding(.top)
            
            ScrollView {
                VStack(spacing: 20) {
                    // 拖拽卡片
                    VStack {
                        Text("拖拽卡片")
                            .font(.headline)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.gray.opacity(0.1))
                                .frame(height: 200)
                            
                            RoundedRectangle(cornerRadius: 15)
                                .fill(isDragging ? Color.green : Color.blue)
                                .frame(width: 150, height: 150)
                                .offset(dragOffset)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            withAnimation(.spring()) {
                                                self.dragOffset = gesture.translation
                                                self.isDragging = true
                                            }
                                        }
                                        .onEnded { _ in
                                            withAnimation(.spring()) {
                                                self.dragOffset = .zero
                                                self.isDragging = false
                                            }
                                        }
                                )
                                .overlay(
                                    Text("拖拽我")
                                        .foregroundColor(.white)
                                )
                        }
                        .frame(height: 200)
                        .padding(.horizontal)
                    }
                    
                    // 缩放图片
                    VStack {
                        Text("缩放图片")
                            .font(.headline)
                        
                        Image(systemName: "photo")
                            .font(.system(size: 80))
                            .scaleEffect(scale)
                            .frame(width: 200, height: 150)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .gesture(
                                MagnificationGesture()
                                    .onChanged { value in
                                        self.scale = value
                                    }
                                    .onEnded { _ in
                                        withAnimation(.spring()) {
                                            self.scale = 1.0
                                        }
                                    }
                            )
                            .overlay(
                                Text("捏合缩放")
                                    .foregroundColor(.secondary)
                                    .padding(.top, 80)
                            )
                    }
                    
                    // 旋转按钮
                    VStack {
                        Text("旋转手势")
                            .font(.headline)
                        
                        ZStack {
                            Circle()
                                .fill(Color.orange.opacity(0.2))
                                .frame(width: 140, height: 140)
                            
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.system(size: 40))
                                .foregroundColor(.orange)
                                .rotationEffect(.degrees(rotationAngle))
                                .frame(width: 100, height: 100)
                                .gesture(
                                    RotationGesture()
                                        .onChanged { angle in
                                            self.rotationAngle = angle.degrees
                                        }
                                        .onEnded { _ in
                                            withAnimation(.spring()) {
                                                // 旋转结束后可以保持当前角度，也可以重置
                                                // self.rotationAngle = 0
                                            }
                                        }
                                )
                        }
                        .overlay(
                            Text("旋转我")
                                .foregroundColor(.secondary)
                                .padding(.top, 150)
                        )
                    }
                    
                    // 可调整位置的方块
                    VStack {
                        Text("自由移动")
                            .font(.headline)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.1))
                                .frame(height: 250)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.purple)
                                .frame(width: 80, height: 80)
                                .position(position)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            withAnimation(.spring()) {
                                                position = gesture.location
                                            }
                                        }
                                )
                                .overlay(
                                    Text("移动")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                )
                        }
                        .frame(height: 250)
                        .clipped()
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("手势动画")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        GestureAnimationView()
    }
} 