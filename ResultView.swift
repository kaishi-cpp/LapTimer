//
//  ContentView.swift
//  LapTimer
//
//  Created by Chiba Kaishi on 2024/09/22.
//

import SwiftUI

struct ResultView: View {
    
    var body: some View {
        GeometryReader { geometry in
            let outerCircleSize = geometry.size.width * 0.9
            ZStack {
                // Background Color
                Color.gray
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    Text("RESULT")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    
                    Text("LAP TIME")
                        .foregroundColor(.white)
                        .font(.title)
                    // show list
                    
                    Text("TIME vs G")
                        .foregroundColor(.white)
                        .font(.title)
                    // show 2 graphs

//                    .padding()
                    Spacer()
                    
                    
                } // End of VStack
            } // End of ZStack
        } // End of GeometryReader
        
    } // End of body
    
}

#Preview {
    ResultView()
}
