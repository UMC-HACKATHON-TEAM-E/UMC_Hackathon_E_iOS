//
//  HomeCollectionViewCell.swift
//  UMC-Hackathon
//
//  Created by 이정동 on 2023/07/03.
//

import UIKit

protocol HomeCollectionViewCellDelegate: AnyObject {
    func okAlertButtonTapped(_ alertController: UIAlertController, indexPath: IndexPath)
}

class HomeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pieChartView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var predictPercent: UILabel!
    @IBOutlet weak var possibilityPercent: UILabel!
    @IBOutlet weak var promise: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    
    weak var delegate: HomeViewController?
    
    private let graphView = GraphView()
    
    var indexPath: IndexPath?
    
    var checked: Bool = false
    
    var goal: Goal?
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
    
    private let percentLabel: UILabel = {
        let label = UILabel()
        label.text = "88%"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let divLabel: UILabel = {
        let label = UILabel()
        label.text = "88/100"
        label.font = UIFont.systemFont(ofSize: 11, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func setData(goal: Goal) {
        self.goal = goal
        title.text = goal.title
        divLabel.text = "\(goal.count)/\(goal.lastDays ?? 1)"
    }
    
    func configureUI() {
        containerView.layer.cornerRadius = 40
        bottomView.layer.cornerRadius = 15
        confirmButton.layer.cornerRadius = 15
        
        containerView.layer.shadowColor = UIColor.black.cgColor // 색깔
        containerView.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4) // 위치조정
        containerView.layer.shadowRadius = 5 // 반경
        containerView.layer.shadowOpacity = 0.3 // alpha값
    }
    
    func configureGraph(percent: Double) {
        
        
        pieChartView.backgroundColor = .clear
        graphView.backgroundColor = .clear
        
        graphView.setOuterRingColor(UIColor(red: 0.65, green: 0.67, blue: 0.71, alpha: 1.00))
        //graphView.setInnerRingColor(.systemBlue)
        graphView.setOuterRingPercentage(percent)
        //graphView.setInnerRingPercentage(0.8)
        
        pieChartView.addSubview(graphView)
        graphView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            graphView.centerXAnchor.constraint(equalTo: pieChartView.centerXAnchor),
            graphView.centerYAnchor.constraint(equalTo: pieChartView.centerYAnchor),
            graphView.widthAnchor.constraint(equalTo: pieChartView.widthAnchor),
            graphView.heightAnchor.constraint(equalTo: pieChartView.heightAnchor)
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
        
        //percentLabel.text = "\(round(percent * 100 * 100) / 100)%"
        percentLabel.text = "\(Int(percent * 100))%"
    }
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        var alert: UIAlertController
        
        if checked {
            alert = UIAlertController(title: goal?.title, message: "오늘 이미 달성한 목표입니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(ok)
        } else {
            let title = goal?.title
            let message = "오늘의 목표를 달성하셨나요?"
            alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "네", style: .default) { _ in
                print("네")
                self.checked = true
                self.delegate?.goalList[self.indexPath!.item].count += 1
                self.delegate?.collectionView.reloadData()
            }
            
            let cancel = UIAlertAction(title: "아니오", style: .cancel) { _ in
                print("아니오")
            }
            
            alert.addAction(ok)
            alert.addAction(cancel)
            
        }
        delegate?.okAlertButtonTapped(alert, indexPath: self.indexPath!)
    }
    
}
