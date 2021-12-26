//
//  StartViewController.swift
//  sliderRgb
//
//  Created by BSergio on 26.12.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewCollor(color: UIColor)
}

class StartViewController: UIViewController {

    // MARK: - IB Outlets
    
    // MARK: - Public Properties
    var setCollor: UIColor = .white
    
    var settingsUICollor: UIColor?
    
    // MARK: - Private Properties
    
    // MARK: - Initializers
    
    // MARK: - Life Cicles Methodes / Overide
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = setCollor
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.setColor = view.backgroundColor
        settingsVC.delegate = self
        
    }
    
    // MARK: - IB Actions
    
    // MARK: - Public Methodes
   
}

// MARK: - Private Methodes
extension StartViewController {
    
}

extension StartViewController: SettingsViewControllerDelegate {
    func setNewCollor(color: UIColor) {
        setCollor = color
    }
    
    
}



