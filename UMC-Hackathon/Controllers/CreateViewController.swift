//
//  CreateViewController.swift
//  UMC-Hackathon
//
//  Created by 이정동 on 2023/07/03.
//

import UIKit

class CreateViewController: UIViewController {
    
    @IBOutlet weak var goalView: UIView!
    @IBOutlet weak var goalTitleTextField: UITextField!
    @IBOutlet weak var goalActivateTextField: UITextField!
    
    
    @IBOutlet weak var detailSettingView: UIView!
    
    @IBOutlet weak var periodTextField: UITextField!
    
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var habitPercentTextField: UITextField!
    
    @IBOutlet weak var promiseTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupUI() {
        goalView.layer.cornerRadius = 15
        detailSettingView.layer.cornerRadius = 15
        promiseTextField.layer.cornerRadius = 15
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        
        print(goalTitleTextField.text)
        print(goalActivateTextField.text)
        print(periodTextField.text)
        print(countTextField.text)
        print(habitPercentTextField.text)
        print(promiseTextField.text)
        
        guard let title = goalTitleTextField.text else { return }
        guard let goalCount = Int(countTextField.text ?? "0") else { return }
        guard let period = Int(periodTextField.text ?? "0") else { return }
        
        let newGoal = NewGoal(userId: 1, title: title, goalCount: goalCount, period: period)
        
        GoalService.shared.createNewGoal(newGoal: newGoal) {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
    }
    
}
