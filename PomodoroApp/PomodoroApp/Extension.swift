//
//  Extension.swift
//  PomodoroApp
//
//  Created by Georgiy on 22.05.2022.
//

import Foundation
import UIKit

extension ViewController {
    
    func setConstraints() {
        view.addSubview(timerLabel)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: Constraints.centerYAnchor).isActive = true
        timerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.leadingAnchor).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constraints.trailingAnchor).isActive = true
        
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.topAnchor.constraint(equalTo: timerLabel.topAnchor, constant: Constraints.topAnchorTwo).isActive = true
        startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.leadingAnchor).isActive = true
        startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constraints.trailingAnchor).isActive = true
        
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: startButton.topAnchor, constant: Constraints.topAnchor).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.leadingAnchor).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constraints.trailingAnchor).isActive = true
    }
    
    func startTimer() {
        timer  = Timer.scheduledTimer(timeInterval: Metric.timeInterval,
                                      target: self,
                                      selector: (#selector(updateTimer)),
                                      userInfo: nil,
                                      repeats: true)
    }
    
    func formatTime() -> String {
        let timeFactor = Int((time).rounded(.up))
        let minutes = timeFactor / 60
        let seconds = timeFactor % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func drawBackLayer(with layerMode: CAShapeLayer, color: UIColor) {
        let end = (-CGFloat.pi / 2)
        let start = 2 * CGFloat.pi + end
        
        layerMode.path = UIBezierPath(arcCenter: view.center,
                                      radius: CGFloat(Radius.radius),
                                      startAngle: start,
                                      endAngle: end, clockwise: false).cgPath
        
        layerMode.strokeEnd = 1
        layerMode.strokeColor = color.cgColor
        layerMode.fillColor = UIColor.clear.cgColor
        layerMode.lineWidth = 10
        view.layer.addSublayer(layerMode)
    }
    
    enum Metric {
        static var timeWork: Double = 10
        static var timeRelax: Double = 5
        static var timeInterval: Double = 0.01
    }
    
    enum StringInfo: String {
        case labelTextWork = "00:10"
        case labelTextRelax = "00:05"
        case startButtonImagePlay = "play"
        case startButtonImagePause = "pause"
        case cancelButtonImage = "clear"
    }
    
    enum Color {
        static var backgroundColor = UIColor.gray
        static var foregroundWorkColor = UIColor.red
        static var foregroundRelaxColor = UIColor.green
    }
    
    enum Sound {
        static var name = "alarm_sound"
        static var format = "mp3"
    }
    
    enum Font {
        static var font = 30
    }
    
    enum Radius {
        static var radius = 150
    }
    
    enum Constraints  {
        static var centerYAnchor: CGFloat = -30
        static var topAnchor: CGFloat = 50
        static var topAnchorTwo: CGFloat = 80
        static var leadingAnchor: CGFloat = 18
        static var trailingAnchor: CGFloat = -18
    }
}
