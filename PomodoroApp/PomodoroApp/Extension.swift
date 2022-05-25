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
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 30),
            startButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        view.addSubview(cancelButton)
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -410),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        view.addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
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
}
