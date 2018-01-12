//
//  AnimationView.swift
//  Unit4FinalAssessment-StudentVersion
//
//  Created by C4Q on 1/12/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class AnimationView: UIView {
    
    lazy var snowmanImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = #imageLiteral(resourceName: "snowman")
        return image
    }()
    
    var presses = 0
    
    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateImage), for: .touchUpInside)
        return button
    }()
    
    @objc func animateImage() {
        switch presses % 3{
        case 0:
            animateWidth()
            animeHeight()
            animateVertical()
            animateFlip()
        case 1:
            pause(layer: snowmanImage.layer)
        default:
            resume(layer: snowmanImage.layer)
        }
        presses += 1
    }
    
    lazy var animationPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .white
        setupViews()
        constrainViews()
    }
    private func setupViews() {
        let viewObjects = [snowmanImage, actionButton, animationPicker] as [UIView]
        viewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false; ($0).centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true}
    }
    private func constrainViews() {
        NSLayoutConstraint.activate([
            snowmanImage.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            snowmanImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            snowmanImage.heightAnchor.constraint(equalTo: snowmanImage.widthAnchor),
            
            animationPicker.topAnchor.constraint(equalTo: snowmanImage.bottomAnchor, constant: 10),
            animationPicker.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            actionButton.topAnchor.constraint(equalTo: animationPicker.bottomAnchor, constant: 5)
            ])
    }
    
    func defaultValues() {
//        snowmanImage.layer.
    }
    
    func animateWidth() {
        let animate = CABasicAnimation(keyPath: "transform.scale")
        let toValue = CATransform3DMakeScale(0.5, 1, 1)
        let fromValue = CATransform3DMakeScale(1, 1, 1)
        
        animate.fromValue = fromValue
        animate.toValue = toValue
        animate.duration = 1
        snowmanImage.layer.add(animate, forKey: nil)
        
    }
    func animeHeight() {
        let animate = CABasicAnimation(keyPath: "transform.scale")
        let fromValue = CATransform3DMakeScale(1, 1, 1)
        let toValue = CATransform3DMakeScale(1, 0.2, 1)
        
        animate.fromValue = fromValue
        animate.toValue = toValue
        animate.duration = 1
        snowmanImage.layer.add(animate, forKey: nil)
    }
    func animateVertical() {
        let fromValue = CATransform3DMakeScale(1, 1, 0)
        let toValue = CATransform3DMakeScale(50, 5, 0)
        
        let animation = CABasicAnimation(keyPath: "transform.translation")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 1.0
        snowmanImage.layer.add(animation, forKey: nil)
    }
    func animateFlip() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.x")
        let angleRadian = CGFloat(2.0 * .pi) // 360
        
        animation.fromValue = 0
        animation.byValue = angleRadian
        animation.duration = 1.0
        snowmanImage.layer.add(animation, forKey: nil)
    }
    
    func pause(layer: CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0
        layer.timeOffset = pausedTime
    }
    
    func resume(layer: CALayer) {
        let pausedTime = layer.timeOffset
        layer.speed = 1
        layer.timeOffset = 0
        layer.beginTime = 0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }

}
