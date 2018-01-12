//
//  AnimationViewController.swift
//  Unit4FinalAssessment-StudentVersion
//
//  Created by C4Q  on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    let animation = AnimationView()
    let settingsVC = SettingsViewController()
    var animationList = [String]() {
        didSet {
            animation.animationPicker.reloadAllComponents()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 1.0)
        view.addSubview(animation)
        constrainViewToSafeArea()
        animation.animationPicker.delegate = self
        animation.animationPicker.dataSource = self
        animationList.append("Default")
    }
    
    func settingArray() {
        if !settingsVC.names.isEmpty {
            animationList = settingsVC.names
        }
    }
    func constrainViewToSafeArea() {
        animation.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            animation.topAnchor.constraint(equalTo: safeArea.topAnchor),
            animation.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            animation.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            animation.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
            ])
    }
    override func viewDidAppear(_ animated: Bool) {
        settingArray()
        animation.animationPicker.reloadAllComponents()
        print(animationList)
    }
    
    
}
extension AnimationViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return animationList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return animationList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let setting = animationList[row]
        
    }
}


