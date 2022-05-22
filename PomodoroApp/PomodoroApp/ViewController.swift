//
//  ViewController.swift
//  PomodoroApp
//
//  Created by Georgiy on 22.05.2022.
//

import UIKit

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
    
    


}

