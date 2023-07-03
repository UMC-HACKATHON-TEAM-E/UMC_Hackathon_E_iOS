//
//  GraphView.swift
//  UMC-Hackathon
//
//  Created by 이정동 on 2023/07/03.
//

import UIKit

class GraphView: UIView {
    
    private var outerRingColor: UIColor = .systemGreen
    private var innerRingColor: UIColor = .systemBlue
    
    private var outerRingPercentage: CGFloat = 0.0
    private var innerRingPercentage: CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawGraph()
    }
    
    private func drawGraph() {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = min(bounds.width, bounds.height) / 2 - 10
        
        let outerRingPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        outerRingColor.setStroke()
        outerRingPath.lineWidth = 20
        outerRingPath.stroke()
        
        let innerRingPath = UIBezierPath(arcCenter: center, radius: radius - 30, startAngle: 0, endAngle: 2 * CGFloat.pi * innerRingPercentage, clockwise: true)
        innerRingColor.setStroke()
        innerRingPath.lineWidth = 20
        innerRingPath.stroke()
        
        let outerRingCoverPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi * outerRingPercentage, clockwise: true)
        UIColor.systemGreen.setStroke()
        outerRingCoverPath.lineWidth = 20
        outerRingCoverPath.stroke()
    }
    
    func setOuterRingColor(_ color: UIColor) {
        outerRingColor = color
        setNeedsDisplay()
    }
    
    func setInnerRingColor(_ color: UIColor) {
        innerRingColor = color
        setNeedsDisplay()
    }
    
    func setOuterRingPercentage(_ percentage: CGFloat) {
        outerRingPercentage = max(0.0, min(1.0, percentage))
        setNeedsDisplay()
    }
    
    func setInnerRingPercentage(_ percentage: CGFloat) {
        innerRingPercentage = max(0.0, min(1.0, percentage))
        setNeedsDisplay()
    }
    
}
