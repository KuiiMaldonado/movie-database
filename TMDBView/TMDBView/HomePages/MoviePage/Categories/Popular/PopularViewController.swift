//
//  PopularViewController.swift
//  TMDBView
//
//  Created by Cuitlahuac Daniel on 25/02/23.
//

import UIKit

protocol PopularViewControllerProtocol {
    func getPopularMovies()
}

class PopularViewController: UIViewController {
    var deslizando: Bool = false
    var flagControl: Bool = true
    var presionado: Bool = false
    var delegate: PopularViewControllerProtocol!
    //MARK: - Properties
    var models : [MovieEntity] = [] {
        didSet {
            loadDataInUI()
        }
    }
    private lazy var collectionView: BaseCollectionView = {
        let collectionView = BaseCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieItemCell.self, forCellWithReuseIdentifier: "cellId")
        return collectionView
    }()
    private lazy var loadingModal: LoadingModal = {
        let modal = LoadingModal(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width , height: self.view.bounds.height))
        modal.backgroundColor = UIColor(red: 20.0/255, green: 32.0/255, blue: 38.0/255, alpha: 1.0)
        return modal
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        delegate.getPopularMovies()
    }
    
    //MARK: - Methods
    func showLoadingModal(_ active : Bool) {
        if active {
            self.view.addSubview(loadingModal)
        } else {
            loadingModal.removeFromSuperview()
        }
    }
}

//MARK: - Private Methods
extension PopularViewController {
    private func commonInit() {
        setupUI()
        setupConstraints()
    }
    private func setupUI() {
        view.backgroundColor = UIColor(red: 12.0/255, green: 21.0/255, blue: 26.0/255, alpha: 1.0)
    }
    private func setupConstraints() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
    private func loadDataInUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension PopularViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MovieItemCell
        let item = models[indexPath.item]
        cell.configure(model: item)
        cell.contentView.addRoundedCorners(radius: 20)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PopularViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("CAFV POPULAR -> El elemento en la posición \(indexPath.row) fue seleccionado")
    }
}
