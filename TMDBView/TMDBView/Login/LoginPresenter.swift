//
//  LoginPresenter.swift
//  TMDBView
//
//  Created Cuitlahuac Daniel on 25/02/23.
//

import UIKit

class LoginPresenter {
    //MARK: - Protocol Properties
    weak private var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    private let router: LoginWireframeProtocol
    
    //MARK: - Life Cycle
    init(interface: LoginViewProtocol, interactor: LoginInteractorProtocol?, router: LoginWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Presenter Methods
extension LoginPresenter: LoginPresenterProtocol {
    func doLogin(email: String, password: String) {
        interactor?.doLoginNow(email: email, password: password)
    }
    
    func success() {
        router.navHomePageView(from: view!)
    }
    
    func error(error: String) {
        view?.showError(error: error)
    }
}
