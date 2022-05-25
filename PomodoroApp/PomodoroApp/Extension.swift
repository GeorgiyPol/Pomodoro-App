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
        timer  = Timer.scheduledTimer(timeInterval: 0.01,
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
        layerMode.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY),
                                      radius: 150,
                                      startAngle: start,
                                      endAngle: end, clockwise: false).cgPath
        
        layerMode.strokeEnd = 1
        layerMode.strokeColor = color.cgColor
        layerMode.fillColor = UIColor.clear.cgColor
        layerMode.lineWidth = 10
        view.layer.addSublayer(layerMode)
    }
    
    enum Constraints  {
        static var centerYAnchor: CGFloat = -30
        static var topAnchor: CGFloat = 50
        static var topAnchorTwo: CGFloat = 80
        static var leadingAnchor: CGFloat = 18
        static var trailingAnchor: CGFloat = -18
    }
}
