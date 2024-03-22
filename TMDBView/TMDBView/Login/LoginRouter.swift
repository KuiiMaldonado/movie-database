//
//  LoginRouter.swift
//  TMDBView
//
//  Created Cuitlahuac Daniel on 25/02/23.
//

import UIKit

class LoginRouter {
    //MARK: - Protocol Properties
    weak var viewController: UIViewController?
    
    //MARK: - Static Methods
    static func createModule() -> UIViewController {
        let view = LoginViewController()
        let interactor = LoginInteractor()
        let router = LoginRouter()
        let presenter = LoginPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}

//MARK: - Router Metods
extension LoginRouter: LoginWireframeProtocol {
    func navHomePageView(from view: LoginViewProtocol) {
        let homePageView = HomePagesRouter.createModule()
        
        if let newView = view as? UIViewController,
           let navController = newView.navigationController {
            navController.pushViewController(homePageView, animated: true)
        }
    }
}
