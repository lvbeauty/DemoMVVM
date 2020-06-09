//
//  MyCollectionViewController.swift
//  Service_Demo
//
//  Created by Tong Yi on 5/28/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

class MyCollectionViewController: UICollectionViewController
{
    private let reuseIdentifier = "Cell"
    
    lazy var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
        setupUI()
        setupCollectionViewFlowLayout()
    }
    
    func setupData()
    {
        MyViewModel.setupData
        {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func setupUI()
    {
        refreshControl.addTarget(self, action: #selector(self.handleRefesh(_:)), for: .valueChanged)
        refreshControl.tintColor = .white
        self.collectionView.addSubview(refreshControl)
    }
    
    func setupCollectionViewFlowLayout()
    {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 170, height: 260)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .black
    }
    
    @objc func handleRefesh(_ refreshControl: UIRefreshControl)
    {
        setupData()
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return MyViewModel.getNumberOfItem()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell

        cell.titleLabel.text = MyViewModel.getImageTitle(item: indexPath.item)
        cell.titleLabel.textColor = .white
        cell.myImageView.contentMode = .scaleAspectFill
        cell.myImageView.image = UIImage(systemName: "book")
        
        // Configure the cell
        MyViewModel.loadImage(item: indexPath.item) { (image) in
            guard let image = image else { return }
            
            cell.myImageView.image = image
        }
        return cell
    }

}
