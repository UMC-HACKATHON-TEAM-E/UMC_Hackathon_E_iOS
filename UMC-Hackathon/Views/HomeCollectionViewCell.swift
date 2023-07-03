//
//  HomeCollectionViewCell.swift
//  UMC-Hackathon
//
//  Created by 이정동 on 2023/07/03.
//

import UIKit

protocol HomeCollectionViewCellDelegate: AnyObject {
    func okAlertButtonTapped(_ alertController: UIAlertController)
}

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pieChartView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var predictPercent: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    
    weak var delegate: HomeCollectionViewCellDelegate?
    
    private let graphView = GraphView()
    
    var checked: Bool = false
    
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
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let divLabel: UILabel = {
        let label = UILabel()
        label.text = "88/100"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func configureUI() {
        containerView.layer.cornerRadius = 40
        bottomView.layer.cornerRadius = 15
        confirmButton.layer.cornerRadius = 15
    }
    
    func configureGraph(percent: Double) {
        
        
        pieChartView.backgroundColor = .clear
        graphView.backgroundColor = .clear
        
        graphView.setOuterRingColor(.systemGray6)
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
    }
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        print("tap")
        
        let title = "근육몬 되기 대작전 인증"
        let message = "헬스장 가기를 이루셨나요?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "네", style: .default) { _ in
            print("네")
            self.checked = true
        }
        
        let cancel = UIAlertAction(title: "아니오", style: .cancel) { _ in
            print("아니오")
            self.checked = false
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        
        delegate?.okAlertButtonTapped(alert)
    }
    
}
