//
//  ViewController.swift
//  TimeCircularBar
//
//  Created by Александр Уткин on 25.07.2021.
//

import UIKit

class ViewController: UIViewController {

    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Some text"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shapeView: UIImageView = {
        let clockView = UIImageView()
        clockView.image = UIImage(named: "circle")
        clockView.translatesAutoresizingMaskIntoConstraints = false
        return clockView
    }()
    
    let cloclLabel: UILabel = {
        let clockLabel = UILabel()
        clockLabel.text = "10"
        clockLabel.font = UIFont.boldSystemFont(ofSize: 60)
        clockLabel.textColor = .black
        clockLabel.textAlignment = .center
        clockLabel.translatesAutoresizingMaskIntoConstraints = false
        return clockLabel
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("START", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var timer = Timer()
    var durationTimer = 10
    let shapeLayer = CAShapeLayer()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.animatedCircular()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setConstraints()
        startButton.addTarget(self, action: #selector(timerStart), for: .touchUpInside)
    }

    @objc func timerStart() {
        
        basicAnimation()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeTime), userInfo: nil, repeats: true)
        print("go")
    }

    @objc func changeTime() {
        
        durationTimer -= 1
        cloclLabel.text = "\(durationTimer)"
        if durationTimer <= 0 {
            timer.invalidate()
            durationTimer = 10
            cloclLabel.text = "\(durationTimer)"
        }
    }
    
    // MARK: ANIMATION
    
    func animatedCircular() {
        
        let center = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        let circularPath = UIBezierPath(arcCenter: center, radius: 138, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1).cgColor
        shapeView.layer.addSublayer(shapeLayer)
    }
    
    func basicAnimation() {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}

extension ViewController {
    func setConstraints() {
        view.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(shapeView)
        NSLayoutConstraint.activate([
            shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shapeView.heightAnchor.constraint(equalToConstant: 300),
            shapeView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(cloclLabel)
        NSLayoutConstraint.activate([
            cloclLabel.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor),
            cloclLabel.centerYAnchor.constraint(equalTo: shapeView.centerYAnchor)
        ])
        
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 70),
            startButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}
