//
//  LoginInteractor.swift
//  TMDBView
//
//  Created Cuitlahuac Daniel on 25/02/23.
//

import UIKit
import FirebaseAuth

class LoginInteractor {
    //MARK: - Protocol Properties
    weak var presenter: LoginPresenterProtocol?
}

//MARK: - Interactor Methods
extension LoginInteractor: LoginInteractorProtocol {
    func doLoginNow(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                self.presenter?.error(error: error?.localizedDescription.description ?? "Ocurrio un error")
                return
            }
            self.presenter?.success()
        }
    }
}
