//
//  ViewController.swift
//  SaveSettings
//
//  Created by Zam on 04.09.2022.
//

import UIKit

class ViewController: UIViewController {

    let settings = UserDefaults.standard
    var mainImage = UIImageView()
    var mainSwitch = UISwitch()
    var mainControl = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getReadyToShow()
        view.addSubview(mainImage)
        view.addSubview(mainSwitch)
        view.addSubview(mainControl)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
            
        view.subviews.forEach { $0.center.x = view.center.x }
        mainImage.center.y = view.center.y - 50
        mainSwitch.center.y = view.center.y + 110
        mainControl.center.y = view.center.y + 155
    }
    
    func getReadyToShow() {
        mainImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        
        mainSwitch = UISwitch(frame: CGRect(x: 0, y: 0, width: 48, height: 32))
        mainSwitch.onTintColor = UIColor(named: "switchColor")
        mainSwitch.addTarget(self, action: #selector(switchAction), for: UIControl.Event.valueChanged)
        
        mainControl = UISegmentedControl(frame: CGRect(x: 0, y: 0, width: 180, height: 30))
        mainControl.insertSegment(withTitle: "L I G H T", at: 0, animated: false)
        mainControl.insertSegment(withTitle: "D A R K", at: 1, animated: false)
        mainControl.selectedSegmentTintColor = .systemGray
        mainControl.setTitleTextAttributes([.foregroundColor: UIColor.systemGray6], for: .selected)
        mainControl.setTitleTextAttributes([.foregroundColor: UIColor.darkGray], for: .normal)
        mainControl.addTarget(self, action: #selector(controlAction), for: UIControl.Event.valueChanged)
                                           
        settings.bool(forKey: "darkMode") ? darkSettings() : lightSettings()
    }
    
    @objc func switchAction(mainSwitch: UISwitch) {
        mainSwitch.isOn ? darkSettings() : lightSettings()
        settings.set(mainSwitch.isOn, forKey: "darkMode")
    }
    
    @objc func controlAction(mainControl: UISegmentedControl) {
        let darkMode = mainControl.selectedSegmentIndex == 1 ? true : false
        darkMode ? darkSettings() : lightSettings()
        settings.set(darkMode, forKey: "darkMode")
    }
    
    func darkSettings() {
        mainSwitch.setOn(true, animated: false)
        mainControl.selectedSegmentIndex = 1
        mainImage.image = UIImage(named: "dark")
        view.backgroundColor = .black
    }
    
    func lightSettings() {
        mainSwitch.setOn(false, animated: false)
        mainControl.selectedSegmentIndex = 0
        mainImage.image = UIImage(named: "light")
        view.backgroundColor = .systemGray4
    }
}

