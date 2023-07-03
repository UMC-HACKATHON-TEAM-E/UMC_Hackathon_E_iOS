//
//  ViewController.swift
//  UMC-Hackathon
//
//  Created by 이정동 on 2023/07/03.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let flowLayout = UICollectionViewFlowLayout()
    
    let data: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
        setupNavigationBar()
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        //cell.customizeChart()
        cell.configureGraph(percent: 0.5)
        cell.configureUI()
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: HomeCollectionViewCellDelegate {
    func okAlertButtonTapped() {
        let title = "근육몬 되기 대작전 인증"
        let message = "헬스장 가기를 이루셨나요?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "네", style: .default) { _ in
            print("네")
        }
        
        let cancel = UIAlertAction(title: "아니오", style: .cancel) { _ in
            print("아니오")
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
