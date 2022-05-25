//
//  Animation.swift
//  PomodoroApp
//
//  Created by Georgiy on 22.05.2022.
//

import Foundation
import UIKit

extension ViewController {
    func resumeAnimationTrueBranch() {
        if !isAnimationStarted {
            startAnimation(with: progressLayerWork, animation: animation)
        } else {
            resumeAnimation(with: progressLayerWork)
        }
    }
    
    func resumeAnimationFalseBranch() {
        if !isAnimationStarted {
            startAnimation(with: progressLayerRelax, animation: animationRelax)
        } else {
            resumeAnimation(with: progressLayerRelax)
        }
    }
    
    func startResumeAnimation() {
        isWorkTime ? resumeAnimationTrueBranch() : resumeAnimationFalseBranch()
    }
    
    func startAnimation(with layerMode: CAShapeLayer, animation: CABasicAnimation) {
        resetAnimation(with: progressLayerRelax)
        layerMode.strokeEnd = 0.0
        animation.keyPath = "strokeEnd"
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = CFTimeInterval(time)
        animation.delegate = self
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        layerMode.add(animation, forKey: "strokeEnd")
        isTimerStarted = true
        isAnimationStarted = true
    }
    
    func resetAnimation(with layerMode: CAShapeLayer) {
        layerMode.speed = 1.0
        layerMode.timeOffset = 0.0
        layerMode.beginTime = 0.0
        layerMode.strokeEnd = 0.0
        isAnimationStarted = false
    }
    
    func pauseAnimation(with layerMode: CAShapeLayer) {
        let pausedTime = layerMode.convertTime(CACurrentMediaTime(), from: nil)
        layerMode.speed = 0.0
        layerMode.timeOffset = pausedTime
    }
    
    func resumeAnimation(with layerMode: CAShapeLayer) {
        let pausedTime = layerMode.timeOffset
        layerMode.speed = 1.0
        layerMode.timeOffset = 0.0
        layerMode.beginTime = 0.0
        let timeSincePaused = layerMode.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layerMode.beginTime = timeSincePaused
    }
    
    func stopAnimation(with layerMode: CAShapeLayer) {
        layerMode.speed = 1.0
        layerMode.timeOffset = 0.0
        layerMode.beginTime = 0.0
        layerMode.strokeEnd = 0.0
        layerMode.removeAllAnimations()
        isAnimationStarted = false
    }
}
