//
//  ViewController.swift
//  sliderRgb
//
//  Created by С on 11.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //    MARK: - IB Outlets
    
    @IBOutlet weak var blueValueLabel: UILabel!
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    
    @IBOutlet weak var screenCollorView: UIView!
    
    @IBOutlet weak var blueTextFields: UITextField!
    @IBOutlet weak var redTextFields: UITextField!
    @IBOutlet weak var greenTextFields: UITextField!
    
    
    //    MARK: - Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blueSlider.minimumTrackTintColor = .blue
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        updateScreen()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        screenCollorView.layer.cornerRadius = 10
    }
    
    //    MARK: - IB Action
    
    @IBAction func slidersAction(_ sender: UISlider) {
        updateScreen()
    }
    
}
// MARK: - Private methods
extension ViewController {
    
    private func updateScreen(){
        blueValueLabel.text = getStringValue(for: blueSlider.value)
        redValueLabel.text = getStringValue(for: redSlider.value)
        greenValueLabel.text = getStringValue(for: greenSlider.value)
        screenCollorView.layer.backgroundColor = CGColor(red: CGFloat(redSlider.value),
                                                         green: CGFloat(greenSlider.value),
                                                         blue: CGFloat(blueSlider.value),
                                                         alpha: 1)
        
    }
    private func getStringValue(for value: Float) -> String {
        let rounding = Float(round(100 * value) / 100)
        return "\(rounding)"
    }
    
}

extension ViewController: UITextFieldDelegate {
    
}
