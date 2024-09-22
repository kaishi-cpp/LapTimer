//
//  MotionViewModel.swift
//  LapTimer
//
//  Created by Chiba Kaishi on 2024/09/22.
//

import SwiftUI
import CoreMotion
import Combine

class MotionViewModel: ObservableObject {
    private var motionManager = CMMotionManager()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var gPositionOffset: CGPoint = .zero
    private var lastAcceleration: CGPoint = .zero
    private let alpha: CGFloat = 0.1    // 0.0~1.0
    
    init() {
        startDeviceMotionUpdates()
    }
    
    private func startDeviceMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            
                motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
                guard let motion = motion else { return }
            
                let deviceAcceleration = motion.userAcceleration
                let transformedAcceleration = self?.transformAcceleration(deviceAcceleration: deviceAcceleration, attitude: motion.attitude)
                    
                if let transformed = transformedAcceleration {
                    let filteredAcceleration = self?.applyLPF(newValue: transformed)
                        
                    if let filtered = filteredAcceleration {
//                        self?.updatePosition(accX: transformed.x, accY: transformed.y)
                        self?.updatePosition(accX: filtered.x, accY: filtered.y)
                    }
                }
            }
        }
    }
    
    private func transformAcceleration(deviceAcceleration: CMAcceleration, attitude: CMAttitude) -> CGPoint {
        let rotationMatrix = attitude.rotationMatrix
        
        let x = CGFloat(deviceAcceleration.x * rotationMatrix.m11 + deviceAcceleration.y * rotationMatrix.m21 + deviceAcceleration.z * rotationMatrix.m31)
        let y = CGFloat(deviceAcceleration.x * rotationMatrix.m12 + deviceAcceleration.y * rotationMatrix.m22 + deviceAcceleration.z * rotationMatrix.m32)
        
        return CGPoint(x: x, y: y)
    }
    
    private func applyLPF(newValue: CGPoint) -> CGPoint {
        lastAcceleration.x = lastAcceleration.x + alpha * (newValue.x - lastAcceleration.x)
        lastAcceleration.y = lastAcceleration.y + alpha * (newValue.y - lastAcceleration.y)
        
        return lastAcceleration
    }
    
    private func updatePosition(accX: CGFloat, accY: CGFloat) {
        gPositionOffset.x = accX * 100
        gPositionOffset.y = accY * 100
        gPositionOffset.y = min(max(gPositionOffset.y, -1000), 1000)
    }
    
    deinit {
        motionManager.stopAccelerometerUpdates()
    }
}
