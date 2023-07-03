//
//  HomeCollectionViewCell.swift
//  UMC-Hackathon
//
//  Created by 이정동 on 2023/07/03.
//

import UIKit
import DGCharts

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pieChart: PieChartView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var predictPercent: UILabel!
    
    let players = ["A", "B"]
    var values: [Double] = [40.0, 60.0]
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //customizeChart()
    }
    
    func customizeChart() {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<players.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: nil, data: players[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        pieChartDataSet.valueTextColor = .black
        pieChartDataSet.drawValuesEnabled = false
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: players.count)
        
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        pieChart.drawEntryLabelsEnabled = false
        pieChart.legend.form = .none
        pieChart.data = pieChartData
        
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
//        var colors: [UIColor] = []
//        for _ in 0..<numbersOfColor {
//            let red = Double(arc4random_uniform(256))
//            let green = Double(arc4random_uniform(256))
//            let blue = Double(arc4random_uniform(256))
//            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
//            colors.append(color)
//        }
        return [UIColor.green, UIColor.gray]
    }
}
