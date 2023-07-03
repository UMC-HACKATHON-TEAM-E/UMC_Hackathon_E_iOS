//
//  DetailViewController.swift
//  UMC-Hackathon
//
//  Created by 이정동 on 2023/07/03.
//

import UIKit


class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var habitNum: UILabel!
    @IBOutlet weak var currentNum: UILabel!
    @IBOutlet weak var Firstprobability: UILabel!
    @IBOutlet weak var secondProbability: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    
    //그래프 들어가는 뷰
    @IBOutlet weak var middleView: UIView!
    
    //그래프 위 제목
    @IBOutlet weak var titleFont: UILabel!
    
    //목표 제목
    @IBOutlet weak var secondTitle: UILabel!
    
    @IBOutlet weak var InformationVIew: UIView!
    
    var percentParameter:Double = 0.0
    
    var left:Int = 0
    var right:Int = 0
    
    var goal: Goal!
    
    var percentValue:Double?{
        didSet{
            if let value = percentValue{
                percentParameter = value
                percentLabel.text = String(format: "%.0f",value) + "%"
            }
        }
    }
    
    
    
    let graphView = GraphView()
    
    //그래프
    private let stackView: UIStackView = {
            let sv = UIStackView()
            sv.axis = .vertical
            sv.spacing = 5
            sv.distribution = .fill
            sv.alignment = .fill
            return sv
        }()
        
            let percentLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize:30, weight: .bold)
            label.textAlignment = .center
            return label
        }()
        
        private let divLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 11, weight: .light)
            label.textColor = .gray
            label.textAlignment = .center
            return label
        }()
    
    
    
    func configureGraph(percent: Double) {
            
            graphView.backgroundColor = .clear
            
        graphView.setOuterRingColor(UIColor(red: 0.65, green: 0.67, blue: 0.71, alpha: 1.00))
            //graphView.setInnerRingColor(.systemBlue)
            graphView.setOuterRingPercentage(percent)
            //graphView.setInnerRingPercentage(0.8)
            
            middleView.addSubview(graphView)
            graphView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                graphView.centerXAnchor.constraint(equalTo: middleView.centerXAnchor),
                graphView.centerYAnchor.constraint(equalTo: middleView.centerYAnchor),
                graphView.widthAnchor.constraint(equalTo: middleView.widthAnchor),
                graphView.heightAnchor.constraint(equalTo: middleView.heightAnchor)
            ])
            
            stackView.addArrangedSubview(percentLabel)
            stackView.addArrangedSubview(divLabel)
            
            graphView.addSubview(stackView)
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            percentLabel.translatesAutoresizingMaskIntoConstraints = false
            divLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: graphView.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: graphView.centerYAnchor)
            ])
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.setGradient(color1: UIColor(red: 0.69, green: 0.32, blue: 0.87, alpha: 1.00), color2: UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.00))
        
        //bottomView
        bottomView.backgroundColor = UIColor.white
        bottomView.layer.cornerRadius = 20
        
        //middleView
        middleView.backgroundColor = UIColor.white
        middleView.layer.cornerRadius = middleView.layer.frame.height/2
        
        
        //informationVIew
        InformationVIew.backgroundColor = .clear
        InformationVIew.layer.borderWidth = 2
        InformationVIew.layer.borderColor = UIColor(red: 0.81, green: 0.83, blue: 0.85, alpha: 1.00).cgColor
        InformationVIew.layer.cornerRadius = 10
        
        //뷰 앞으로 가져오기
        self.view.bringSubviewToFront(bottomView)
        self.view.bringSubviewToFront(middleView)
        self.view.bringSubviewToFront(titleFont)
        self.view.bringSubviewToFront(secondTitle)
        self.view.bringSubviewToFront(InformationVIew)
        
        configureGraph(percent: percentParameter)
        
        var left = goal.count
        var right = goal.lastDays
        var result = (left) / (right ?? 1)
        
        var first:Int = Int(Firstprobability.text ?? "") ?? 0
        var second:Int = Int(secondProbability.text ?? "") ?? 0
        
        var result2 = first / second
        
        
        divLabel.text = "\(left)/\(right!)"
        
        
        
        Firstprobability.text = String(result2) + "%"
        secondProbability.text = String(result) + "%"
        
       
    }


}

extension UIView{
    func setGradient(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
