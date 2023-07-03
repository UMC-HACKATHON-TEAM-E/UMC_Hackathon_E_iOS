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
        
        
        periodTextField.layer.cornerRadius = 10
        countTextField.layer.cornerRadius = 10
        habitPercentTextField.layer.cornerRadius = 10
        detailSettingView.layer.cornerRadius = 10
        promiseTextField.layer.cornerRadius = 10
        goalView.layer.cornerRadius = 10
        // Do any additional setup after loading the view
        setupUI()
        
        periodTextField.delegate = self
        countTextField.delegate = self
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
        guard let promise = promiseTextField.text else { return }
  
        
        let goal = Goal(goalID: 3, title: title, startDate: "2023.07.04", endDate: "", goalCount: goalCount, user: User(id: 1, email: "", password: "", name: ""), period: period, count: 0, promise: promise, lastDays: 1)
        
        guard let vcStack = self.navigationController?.viewControllers else { return }
        for view in vcStack {
            if let vc = view as? HomeViewController {
                //vc.goalList.insert(goal, at: 0)
                vc.goalList.append(goal)
                
                self.navigationController?.popToViewController(vc, animated: true)
                vc.collectionView.reloadData()
            }
        }
//        let newGoal = NewGoal(userId: 1, title: title, goalCount: goalCount, period: period)
//
//        GoalService.shared.createNewGoal(newGoal: newGoal) {
//            DispatchQueue.main.async {
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
        
        
    }
    
}

extension CreateViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if periodTextField.text != "" && countTextField.text != "" {
            print("dd")
            let period = Double(periodTextField.text!)!
            let count = Double(countTextField.text!)!
            habitPercentTextField.text = "\(Int((count / period) * 100))"
        }
    }
}
