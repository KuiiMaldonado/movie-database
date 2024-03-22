//
//  MoviesPageViewController.swift
//  TMDBView
//
//  Created by Cuitlahuac Daniel on 04/03/23.
//

import UIKit

class HomePagesViewController: BaseViewController {
    //MARK: - Protocol Properties
    var presenter: HomePagesPresenterProtocol?
    
    //MARK: - Properties
    private var popularViewController = PopularViewController()
    private var topRatedViewController = TopRatedViewController()
    private var onTvViewController = OnTvViewController()
    private var airingTodayViewController = AiringTodayViewController()
    private var pageViewController: UIPageViewController!
    private var currentPageIndex : Int = 0
    private lazy var viewControllers: [UIViewController] = {
        return [popularViewController,
                topRatedViewController,
                onTvViewController,
                airingTodayViewController]
    }()
    private lazy var uiView : UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 12.0/255, green: 21.0/255, blue: 26.0/255, alpha: 1.0)
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    private lazy var collectionView : CategoriesView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = CategoriesView(frame: CGRect(x: 20, y: 10, width: view.bounds.width - 40, height: 35), collectionViewLayout: layout)
        return collectionView
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

//MARK: - Private Methods
extension HomePagesViewController {
    private func commonInit() {
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 38.0/255, green: 44.0/255, blue: 46.0/255, alpha: 1.0)
        configNavigationBar()
        popularViewController.delegate = self
        topRatedViewController.delegate = self
        onTvViewController.delegate = self
        airingTodayViewController.delegate = self
        collectionView.delegateTabsView = self
        setupPageViewController()
    }
    
    private func setupPageViewController() {
        // Configurar el UIPageViewController
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        // Agregar las páginas al UIPageViewController
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: false, completion: nil)
        pageViewController.addChild(viewControllers[0])
        pageViewController.addChild(viewControllers[1])
        pageViewController.addChild(viewControllers[2])
        pageViewController.addChild(viewControllers[3])
        
        pageViewController.view.frame = CGRect(x: 0, y: 145, width: view.bounds.width, height: view.bounds.height - 145)
        pageViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pageViewController.edgesForExtendedLayout = []
        
        self.pageViewController = pageViewController
    }
    
    private func setupConstraints() {
        view.addSubview(uiView)
        uiView.addSubview(collectionView)
        
        addChild(self.pageViewController)
        view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            uiView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            uiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uiView.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

extension HomePagesViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return viewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController), index < viewControllers.count - 1 else {
            return nil
        }
        return viewControllers[index + 1]
    }
}

//MARK: - HomePagesViewProtocol
extension HomePagesViewController: HomePagesViewProtocol {
    @MainActor func showLoader(_ active: Bool) async throws {
        popularViewController.showLoadingModal(active)
    }
    
    func showMovies(category: PopularAndTopRated, movies: [MovieEntity]) {
        switch category {
        case .popular:
            self.popularViewController.models = movies
        case .topRated:
            self.topRatedViewController.models = movies
        }
    }
    
    func showTVPrograms(category: OnTVAndAiringToday, movies: [TVEntity]) {
        switch category {
        case .OnTV:
            self.onTvViewController.models = movies
        case .AiringToday:
            self.airingTodayViewController.models = movies
        }
    }
}

//MARK: - TabsViewProtocol
extension HomePagesViewController : TabsViewProtocol {
    func didSelectOption(index: Int) {print("CAFV select of 0 to 3: ", index)
        var direction : UIPageViewController.NavigationDirection = .forward
        if index < currentPageIndex {
            direction = .reverse
        }
        self.pageViewController.setViewControllers([viewControllers[index]], direction: direction, animated: true)
        currentPageIndex = index
    }
}

//MARK: - PopularViewControllerProtocol
extension HomePagesViewController: PopularViewControllerProtocol {
    func getPopularMovies() {
        presenter?.fetch(category: .popular)
    }
}

//MARK: - TopRatedViewControllerProtocol
extension HomePagesViewController: TopRatedViewControllerProtocol {
    func getTopRatedMovies() {
        presenter?.fetch(category: .topRated)
    }
}

//MARK: - OnTvViewControllerProtocol
extension HomePagesViewController: OnTvViewControllerProtocol {
    func getOnTvPrograms() {
        presenter?.fetch(category: .OnTV)
    }
}

//MARK: - AiringTodayViewControllerProtocol
extension HomePagesViewController: AiringTodayViewControllerProtocol {
    func getAiringTodayPrograms() {
        presenter?.fetch(category: .AiringToday)
    }
}
