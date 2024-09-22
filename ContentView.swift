//
//  ContentView.swift
//  LapTimer
//
//  Created by Chiba Kaishi on 2024/09/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var timerViewModel = TimerViewModel()
    @StateObject private var motionViewModel = MotionViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let outerCircleSize = geometry.size.width * 0.9
            ZStack {
                // Background Color
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    Text("LAP TIMER")
                        .foregroundColor(.white)
                        .font(.title)

//                    Text("\(timerViewModel.count) ms")
                    Text(formatTime(timerViewModel.count))
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    
                    ZStack {
                        // Outer Circle
                        ZStack {
                            Circle()
//                                .foregroundColor(.gray)
                                .fill(.gray)
                                .stroke(Color.white, lineWidth: 5)
                                .frame(width: outerCircleSize, height: outerCircleSize)
                            
                            Circle()
                            //                                .foregroundColor(.gray)
                                .fill(.clear)
                                .stroke(Color.white, lineWidth: 1)
                                .frame(width: outerCircleSize / 2, height: outerCircleSize / 2)
                            
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 1, height : outerCircleSize)
                            
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: outerCircleSize, height : 1)
                        }
                        .frame(width:  geometry.size.width, height:  geometry.size.width)
                        .position(x: geometry.size.width / 2, y: geometry.size.width / 2)
    //                    .alignmentGuide(.center) { }
    //                    .edgesIgnoringSafeArea(.all)
                        
                        Circle()
                            .foregroundColor(.red)
                            .frame(width: 50, height: 50)
                            .position(x: geometry.size.width / 2 + motionViewModel.gPositionOffset.x, y: geometry.size.width / 2 + motionViewModel.gPositionOffset.y)

                    } // End of ZStack
                    
                    HStack {
                        // Lap Start Button
                        Button(action: timerViewModel.startTimer) {
                            Text("START")
                                .font(.title)
                                .frame(width: 130, height: 50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 3)
                                )
                        }
                        .foregroundColor(.red)
                        
                        // Lap Stop Button
                        Button(action: timerViewModel.stopTimer) {
                            Text("STOP")
                                .font(.title)
                                .frame(width: 130, height: 50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 3)
                                )
                        }
                        .foregroundColor(.red)
                    } // End of HStack
//                    .padding()
                    Spacer()
                } // End of VStack
            } // End of ZStack
        } // End of GeometryReader
        
    } // End of body
    
    private func formatTime(_ milliseconds: Int) -> String {
        let minutes = (milliseconds / 60000) % 60
        let seconds = (milliseconds / 1000) % 60
        let millis = milliseconds % 1000
        
        return String(format: "%02d:%02d:%03d", minutes, seconds, millis)
    }
}

#Preview {
    ContentView()
}
