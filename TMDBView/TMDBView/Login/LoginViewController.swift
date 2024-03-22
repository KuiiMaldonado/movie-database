//
//  LoginViewController.swift
//  TMDBView
//
//  Created Cuitlahuac Daniel on 25/02/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //MARK: - Protocol Properties
    var presenter: LoginPresenterProtocol?
    
    //MARK: - Properties
    private lazy var loadingModal: LoadingModal = {
        let modal = LoadingModal(frame: self.view.bounds)
        return modal
    }()
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.borderStyle = .roundedRect
        return textField
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.borderStyle = .roundedRect
        return textField
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 216.0/255, green: 214.0/255, blue: 218.0/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.Login), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

//MARK: - LoginViewProtocol
extension LoginViewController: LoginViewProtocol {
    func showError(error: String) {
        loadingModal.removeFromSuperview()
        self.errorLabel.text = error
    }
}
//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - Private Methods
extension LoginViewController {
    private func commonInit() {
        setupConstraints()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(red: 18.0/255, green: 32.0/255, blue: 38.0/255, alpha: 1.0)
    }
    
    private func setupConstraints() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        view.addSubview(logoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            usernameTextField.heightAnchor.constraint(equalToConstant: 55),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            loginButton.heightAnchor.constraint(equalToConstant: 55),
            
            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func Login() {
        self.view.addSubview(loadingModal)
        if let email = usernameTextField.text, let password = passwordTextField.text{
            presenter?.doLogin(email: email, password: password)
        } else {
            print("CAFV Falta hacer algo aqui.")
        }
    }
    
}
