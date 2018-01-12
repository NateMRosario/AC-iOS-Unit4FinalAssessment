//
//  SettingCell.swift
//  Unit4FinalAssessment-StudentVersion
//
//  Created by C4Q on 1/12/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    
    let vc = SettingsViewController()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var settingStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        return stepper
    }()
    
    @objc func stepperValueChanged(sender:UIStepper!)
    {
        vc.counter = sender.value
        print("It Works, Value is\(Int(sender.value).description)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "SettingCell")
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    private func setupViews() {
        let viewObjects = [nameLabel, settingStepper] as [UIView]
        viewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false; ($0).centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true}
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            settingStepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])
    }
    
    func configureCell(settings: AnimationProperty, count: Double) {
        nameLabel.text = "\(settings.name): \(count)"
        settingStepper.maximumValue = settings.stepperMax
        settingStepper.minimumValue = settings.stepperMin
        settingStepper.stepValue = settings.stepperIncrement
        settingStepper.value = settings.startingStepperVal
        
        
    }
    
}
