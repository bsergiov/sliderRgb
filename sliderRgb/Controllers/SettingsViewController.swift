//
//  ViewController.swift
//  sliderRgb
//
//  Created by С on 11.12.2021.
//

import UIKit

class SettingsViewController: UIViewController{
    
    
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
    
    // MARK: - Public Properties
    var setColor: UIColor?
    
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Private Properties
    private var redFloat: Float!
    private var greenFloat: Float!
    private var blueFloat: Float!
    
    //    MARK: - Live Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redFloat = Float(setColor?.getRed ?? 0)
        greenFloat = Float(setColor?.getGreen ?? 0)
        blueFloat = Float(setColor?.getBlue ?? 0)
        
        blueTextFields.delegate = self
        redTextFields.delegate = self
        greenTextFields.delegate = self
        
        addDoneButtonKeyboards()
        
        setColorTintMinSliders()
        setValueSliders()
        setLabelText()
        setValueTextFields()
        updateCollor()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        screenCollorView.layer.cornerRadius = 10
    }
    
    // MARK: - Overide methodew
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if touches.first != nil {
            view.endEditing(true)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //    MARK: - IB Action
    @IBAction func slidersAction(_ sender: UISlider) {
        updateCollor()
        setLabelText()
        setValueTextFields()
    }
    
    @IBAction func doneTapped() {
        view.endEditing(true)
        if let color = screenCollorView.backgroundColor {
            delegate.setNewCollor(color: color)
        }
        dismiss(animated: true)
    }
    
}
// MARK: - Private methods
extension SettingsViewController {
    
    private func addDoneButtonKeyboards() {
        let positionToolbar = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        let doneToolbar: UIToolbar = UIToolbar(frame: positionToolbar)
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector (doneButtonAction))
        
        let items = [flexSpace, done]
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        redTextFields.inputAccessoryView = doneToolbar
        greenTextFields.inputAccessoryView = doneToolbar
        blueTextFields.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        view.endEditing(true)
    }
    
    private func setValueSliders() {
        redSlider.value = redFloat
        greenSlider.value = greenFloat
        blueSlider.value = blueFloat
    }
    
    private func setLabelText() {
        redValueLabel.text = getStringValue(for: redSlider.value)
        blueValueLabel.text = getStringValue(for: blueSlider.value)
        greenValueLabel.text = getStringValue(for: greenSlider.value)
    }
    
    private func setValueTextFields() {
        blueTextFields.text = getStringValue(for: blueSlider.value)
        redTextFields.text = getStringValue(for: redSlider.value)
        greenTextFields.text = getStringValue(for: greenSlider.value)
    }
    
    private func updateCollor(){
        screenCollorView.layer.backgroundColor = CGColor(red: CGFloat(redSlider.value),
                                                         green: CGFloat(greenSlider.value),
                                                         blue: CGFloat(blueSlider.value),
                                                         alpha: 1)
        
    }
    
    private func setColorTintMinSliders() {
        blueSlider.minimumTrackTintColor = .blue
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
    }
    
    private func getStringValue(for value: Float) -> String {
        let rounding = Float(round(100 * value) / 100)
        return "\(rounding)"
    }
    
    private func showAllertViewController(title: String, message: String) {
        let allert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(allert, animated: true, completion: nil)
    }
    
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
       
        guard let textFieldString = textField.text else { return }

        guard let valueFloatColor = Float(textFieldString) else {
            showAllertViewController(title: "Invalide data",
                                     message: "The data must be in the range from 0 to 1")
            return }
        
        if valueFloatColor < 0 || valueFloatColor > 1  {
            showAllertViewController(title: "Invalide data",
                                     message: "The data must be in the range from 0 to 1")
            return
        }
        switch textField.tag {
        case 0: // blue
            blueValueLabel.text = textField.text
            blueSlider.value = valueFloatColor
            
        case 1: // red
            redValueLabel.text = textField.text
            redSlider.value = valueFloatColor
            
        default: //green
            greenValueLabel.text = textField.text
            greenSlider.value = valueFloatColor
            
        }
        view.endEditing(true)
        updateCollor()
    }
}

// MARK: - Get value color R G B
extension UIColor {
    var getRed: CGFloat {
        CIColor(color: self).red
    }
    
    var getGreen: CGFloat {
        CIColor(color: self).green
    }
    
    var getBlue: CGFloat {
        CIColor(color: self).blue
    }
    
}


