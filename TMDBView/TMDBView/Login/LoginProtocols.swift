//
//  LoginProtocols.swift
//  TMDBView
//
//  Created Cuitlahuac Daniel on 25/02/23.
//

import Foundation

//MARK: Wireframe -
protocol LoginWireframeProtocol: AnyObject {
    func navHomePageView(from view: LoginViewProtocol)
}
//MARK: Presenter -
protocol LoginPresenterProtocol: AnyObject {
    func doLogin(email: String, password: String)
    func success()
    func error(error: String)
}

//MARK: Interactor -
protocol LoginInteractorProtocol: AnyObject {
    var presenter: LoginPresenterProtocol?  { get set }
    func doLoginNow(email: String, password: String)
}

//MARK: View -
protocol LoginViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocol?  { get set }
    func showError(error: String)
}
