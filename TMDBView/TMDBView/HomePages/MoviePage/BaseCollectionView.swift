//
//  BaseCollectionView.swift
//  TMDBView
//
//  Created by Cuitlahuac Daniel on 25/02/23.
//

import UIKit

class BaseCollectionView: UICollectionView {
    //MARK: - Properties
    private let cellWidth: CGFloat = ((UIScreen.main.bounds.width / 2) - 30)
    private let cellHeight: CGFloat = ((UIScreen.main.bounds.height / 3))
    
    //MARK: - Life Cycle
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        super.init(frame: frame, collectionViewLayout: flowLayout)
        self.backgroundColor = UIColor(red: 12.0/255, green: 21.0/255, blue: 26.0/255, alpha: 1.0)
        self.showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}
