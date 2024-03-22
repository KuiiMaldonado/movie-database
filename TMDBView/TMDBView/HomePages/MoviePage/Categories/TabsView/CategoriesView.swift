//
//  FourButtonCollectionView.swift
//  TMDBView
//
//  Created by Cuitlahuac Daniel on 25/02/23.
//

import UIKit

class CategoriesView: UICollectionView {
    //MARK: - Properties
    private let buttonTitles = ["Popular", "Top Rated", "On TV", "Airing Today"]
    private let cellWidth: CGFloat = ((UIScreen.main.bounds.width / 4) - 15)
    weak var delegateTabsView: TabsViewProtocol?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCollectionView()
    }
}

//MARK: - Private Methods
extension CategoriesView {
    private func configureCollectionView() {
        self.backgroundColor = UIColor(red: 20.0/255, green: 32.0/255, blue: 38.0/255, alpha: 1.0)
        self.showsHorizontalScrollIndicator = false
        self.dataSource = self
        self.delegate = self
        self.register(CategoryViewCell.self, forCellWithReuseIdentifier: "ButtonCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: cellWidth, height: self.bounds.height)
        self.collectionViewLayout = layout
    }
}

//MARK: - UICollectionViewDataSource UICollectionViewDelegate
extension CategoriesView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath) as! CategoryViewCell
        cell.configure(title: buttonTitles[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegateTabsView?.didSelectOption(index: indexPath.item)
    }
}
