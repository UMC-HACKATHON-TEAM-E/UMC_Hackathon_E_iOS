//
//  ViewController.swift
//  UMC-Hackathon
//
//  Created by 이정동 on 2023/07/03.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var sendData:Double = 0.0
    
    let flowLayout = UICollectionViewFlowLayout()
    
    var goalList: [Goal] = [
        Goal(goalID: 1, title: "백준 골드 가보자!", startDate: "", endDate: "", goalCount: 150, user: User(id: 1, email: "", password: "", name: ""), period: 200, count: 0, possibility: 0, promise: "알고리즘 고수가 되기까지 천천히 시작해보자!"),
        Goal(goalID: 1, title: "내 몸을 건강하게", startDate: "", endDate: "", goalCount: 100, user: User(id: 1, email: "", password: "", name: ""), period: 100, count: 34, possibility: 100, promise: "하루도 빠지지 말고 끝까지 해내보자")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        setupCollectionView()
        setupNavigationBar()
        
//        GoalService.shared.requestGoalList(userId: 1) { goalList in
//            self.goalList = goalList
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: view.frame.width, height: 240)
        collectionView.collectionViewLayout = flowLayout
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped))
    }
    
    @objc func rightBarButtonTapped() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateViewController") as! CreateViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goalList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        //cell.customizeChart()
        let goal = goalList[indexPath.item]
        
        //전달
        let percent = Double(goal.count) / Double(goal.goalCount)
        
        cell.setData(goal: goal)
        cell.configureGraph(percent: Double(goal.count) / Double(goal.goalCount))
        cell.configureUI()
        cell.possibilityPercent.text = "\(goal.possibility ?? 0)%"
        cell.promise.text = goal.promise ?? ""
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
        
    }
    
    //눌렀을 때 화면 전환
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let goal = goalList[indexPath.item]
        let percent = (Double(goal.count) / Double(goal.goalCount))*100
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.percentValue = percent
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: HomeCollectionViewCellDelegate {
    func okAlertButtonTapped(_ alertController: UIAlertController, indexPath: IndexPath) {
        
        present(alertController, animated: true)
    }
}
