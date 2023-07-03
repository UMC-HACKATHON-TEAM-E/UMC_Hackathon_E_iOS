//
//  HomeCollectionViewCell.swift
//  UMC-Hackathon
//
//  Created by 이정동 on 2023/07/03.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pieChartView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var predictPercent: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    
    private let graphView = GraphView()
    
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
    }
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
    }
    
}
