//
//  RootPageViewControllers.swift
//  TMDBView
//
//  Created by Cuitlahuac Daniel on 25/02/23.
//

import UIKit

class RootPageViewControllers: UIPageViewController {
    //MARK: - Properties
    weak var delegateRoot : RootPageProtocol?
    private var myViewControllers: [UIViewController] = []
    
    //MARK: - Life Cycle
    init(viewControllers: [UIViewController]) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.myViewControllers = viewControllers
        self.dataSource = self
        self.delegate = self
        _ = myViewControllers.enumerated().map({$0.element.view.tag = $0.offset})
        setViewControllerFromIndex(index: 0, direction: .forward)
        _ = myViewControllers.enumerated().map({$0.element.view.tag = $0.offset})
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setViewControllerFromIndex(index: Int, direction: NavigationDirection, animated: Bool = true){
        setViewControllers([myViewControllers[index]], direction: direction, animated: animated)
    }
}

// MARK: - UIPageViewControllerDataSource UIPageViewControllerDelegate
extension RootPageViewControllers : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return myViewControllers.count
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = myViewControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return myViewControllers[index - 1]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = myViewControllers.firstIndex(of: viewController), index < myViewControllers.count - 1 else {
            return nil
        }
        return myViewControllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let index = pageViewController.viewControllers?.first?.view.tag{
            switch index {
            case 0: delegateRoot?.currentPage(.popular)
            case 1: delegateRoot?.currentPage(.topRated)
            case 2: delegateRoot?.currentPage(.OnTV)
            case 3: delegateRoot?.currentPage(.AiringToday)
            default: delegateRoot?.currentPage(.popular)
            }
        }
    }
}
