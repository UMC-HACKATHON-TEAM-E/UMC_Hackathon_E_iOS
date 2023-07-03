//
//  GraphView.swift
//  UMC-Hackathon
//
//  Created by 이정동 on 2023/07/03.
//

import UIKit
import Hue
class GraphView: UIView {
    
    private var outerRingColor: UIColor = .systemGreen
    private var innerRingColor: UIColor = .systemBlue
    
    private var outerRingPercentage: CGFloat = 0.0
    private var innerRingPercentage: CGFloat = 0.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawGraph()
    }
/*
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
       
        /*
        let outerRingCoverPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi * outerRingPercentage, clockwise: true)
        UIColor(red: 0.69, green: 0.32, blue: 0.87, alpha: 1.00).setStroke()
        UIColor.systemCyan.setStroke()
        outerRingCoverPath.lineWidth = 20
        outerRingCoverPath.stroke()
         */
 
 */
    
    
    private func drawGraph() {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = min(bounds.width, bounds.height) / 2 - 10
        
        let outerRingPath = UIBezierPath(arcCenter: center, radius: radius - 10, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        outerRingColor.setStroke()
        outerRingPath.lineWidth = 20
        outerRingPath.stroke()
        
        let innerRingPath = UIBezierPath(arcCenter: center, radius: radius - 20, startAngle: 0, endAngle: 2 * CGFloat.pi * innerRingPercentage, clockwise: true)
        innerRingColor.setStroke()
        innerRingPath.lineWidth = 20
        innerRingPath.stroke()
        
        let outerRingCoverPath = CGMutablePath()
        outerRingCoverPath.addArc(center: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi * outerRingPercentage, clockwise: false)
        outerRingCoverPath.addArc(center: center, radius: radius - 20, startAngle: 2 * CGFloat.pi * outerRingPercentage, endAngle: 0, clockwise: true)
        
        let shapeMask = CAShapeLayer()
        shapeMask.path = outerRingCoverPath
        shapeMask.fillRule = .evenOdd
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 1, width: self.bounds.width, height: self.bounds.height)
      //  gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.00).cgColor, UIColor(red: 0.69, green: 0.32, blue: 0.87, alpha: 1.00).cgColor]

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        gradientLayer.mask = shapeMask
        self.layer.addSublayer(gradientLayer)
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
