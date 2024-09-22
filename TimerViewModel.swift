//
//  TimerViewModel.swift
//  LapTimer
//
//  Created by Chiba Kaishi on 2024/09/22.
//

import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    @Published var count: Int = 0
    private var timer: AnyCancellable?
    
    func startTimer() {
        if timer == nil {
            timer = Timer.publish(every: 0.001, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    self?.count += 1
                }
        }
    }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
}
