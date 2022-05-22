//
//  ViewController.swift
//  PomodoroApp
//
//  Created by Georgiy on 22.05.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, CAAnimationDelegate  {
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:10"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.red
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let startButton: UIButton = {
        let startButton = UIButton()
        startButton.setImage(UIImage(systemName: "play"), for: .normal)
        startButton.imageView?.layer.transform = CATransform3DMakeScale(3, 3, 3)
        startButton.tintColor = UIColor.red
        startButton.translatesAutoresizingMaskIntoConstraints = false
        return startButton
    }()
    
    let cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setImage(UIImage(systemName: "clear"), for: .normal)
        cancelButton.imageView?.layer.transform = CATransform3DMakeScale(3, 3, 3)
        cancelButton.tintColor = UIColor.red
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        return cancelButton
    }()
    
    var player: AVAudioPlayer! = nil
    var timer = Timer()
    var isTimerStarted = false
    var time = 10
    var isAnimationStarted = false
    var isWorkTime = true
    
    let progressLayerWork = CAShapeLayer()
    let progressLayerRelax = CAShapeLayer()
    let backProgressLayer = CAShapeLayer()
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    let animationRelax = CABasicAnimation(keyPath: "strokeEnd")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        
        startButton.addTarget(self,
                              action: #selector(startButtonTapped),
                              for: .touchUpInside)
        
        cancelButton.addTarget(self,
                               action: #selector(cancelButtonTapped),
                               for: .touchUpInside)
    }
    
    @objc func startButtonTapped() {
        if isWorkTime {
            cancelButton.isEnabled = true
            cancelButton.alpha = 1
            if !isTimerStarted {
                startResumeAnimation()
                startTimer()
                isTimerStarted = true
                startButton.setImage(UIImage(systemName: "pause"), for: .normal)
                startButton.tintColor = UIColor.black
            } else {
                pauseAnimation(with: progressLayerWork)
                timer.invalidate()
                isTimerStarted = false
                startButton.setImage(UIImage(systemName: "play"), for: .normal)
                startButton.tintColor = UIColor.red
            }
        } else {
            cancelButton.isEnabled = true
            cancelButton.alpha = 1
            if !isTimerStarted {
                startResumeAnimation()
                startTimer()
                isTimerStarted = true
                startButton.setImage(UIImage(systemName: "pause"), for: .normal)
                startButton.tintColor = UIColor.black
            } else {
                pauseAnimation(with: progressLayerRelax)
                timer.invalidate()
                isTimerStarted = false
                startButton.setImage(UIImage(systemName: "play"), for: .normal)
                startButton.tintColor = UIColor.green
            }
        }
    }
    
    @objc func cancelButtonTapped() {
        if isWorkTime {
            stopAnimation(with: progressLayerWork)
            cancelButton.isEnabled = false
            cancelButton.alpha = 0.5
            
            timer.invalidate()
            time = 5
            isTimerStarted = false
            timerLabel.text = "00:05"
            startButton.setImage(UIImage(systemName: "play"), for: .normal)
            startButton.tintColor = UIColor.red
            drawBackLayer(with: progressLayerWork, color: UIColor.red)
            
        } else {
            stopAnimation(with: progressLayerRelax)
            cancelButton.isEnabled = false
            cancelButton.alpha = 0.5
            
            timer.invalidate()
            time = 5
            isTimerStarted = false
            timerLabel.text = "00:05"
            startButton.setImage(UIImage(systemName: "play"), for: .normal)
            startButton.tintColor = UIColor.green
            drawBackLayer(with: progressLayerRelax, color: UIColor.green)
        }
    }
    
    @objc func updateTimer() {
        if time < 1 && !isWorkTime {
            startButton.setImage(UIImage(systemName: "play"), for: .normal)
            startButton.tintColor = UIColor.red
            cancelButton.tintColor = UIColor.red
            time = 10
            timerLabel.text = "00:10"
            timerLabel.textColor = UIColor.red
            timer.invalidate()
            isTimerStarted = false
            isWorkTime = true
            drawBackLayer(with: backProgressLayer, color: UIColor.gray)
            drawBackLayer(with: progressLayerWork, color: UIColor.red)
            isAnimationStarted = false
            music()
        } else if time < 1 {
            startButton.setImage(UIImage(systemName: "play"), for: .normal)
            startButton.tintColor = UIColor.green
            time = 5
            timerLabel.text = "00:05"
            timerLabel.textColor = UIColor.green
            timer.invalidate()
            isTimerStarted = false
            isWorkTime = false
            drawBackLayer(with: backProgressLayer, color: UIColor.gray)
            drawBackLayer(with: progressLayerRelax, color: UIColor.green)
            cancelButton.tintColor = UIColor.green
            isAnimationStarted = false
            music()
        } else {
            time -= 1
            timerLabel.text = formatTime()
        }
    }
    
    
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
        timer  = Timer.scheduledTimer(timeInterval: 1,
                                      target: self,
                                      selector: (#selector(updateTimer)),
                                      userInfo: nil,
                                      repeats: true)
    }
    
    func formatTime() -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}
