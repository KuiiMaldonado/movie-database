//
//  HomePagesRouter.swift
//  TMDBView
//
//  Created Cuitlahuac Daniel on 25/02/23.
//

import UIKit

class HomePagesRouter {
    //MARK: - Protocol Properties
    weak var viewController: UIViewController?
    
    //MARK: - Static Methods
    static func createModule() -> UIViewController {
        let view = HomePagesViewController(nibName: nil, bundle: nil)
        let interactor = HomePagesInteractor.shared
        let router = HomePagesRouter()
        let presenter = HomePagesPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}

//MARK: - Router Metods
extension HomePagesRouter: HomePagesWireframeProtocol {
}
