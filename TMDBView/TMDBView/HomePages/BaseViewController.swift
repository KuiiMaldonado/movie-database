//
//  BaseViewController.swift
//  TMDBView
//
//  Created by Cuitlahuac Daniel on 25/02/23.
//

import UIKit
import FirebaseAuth

class BaseViewController: UIViewController {
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - functions
    func configNavigationBar(hideBackButton : Bool = true, title : String = "TV Shows"){
        self.buildButton(image: (UIImage(systemName: "line.horizontal.3")?.withTintColor(.white))!, selector: #selector(menuButtonPressed))
        navigationItem.hidesBackButton = hideBackButton
        self.navigationItem.title = title
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
}

//MARK: - Private Methods
extension BaseViewController {
    private func buildButton(image: UIImage, selector: Selector) {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        let extraPadding: CGFloat = 2.0
        button.imageEdgeInsets = UIEdgeInsets(top: extraPadding, left: extraPadding, bottom: extraPadding, right: extraPadding)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let barButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func menuButtonPressed() {
        let alertController = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .actionSheet)
        alertController.view.tintColor = .systemBlue
        alertController.view.backgroundColor = .clear
        
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let messageAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let attributedTitle = NSAttributedString(string: "What do you want to do?", attributes: titleAttributes)
        let attributedMessage = NSAttributedString(string: "", attributes: messageAttributes)
        
        alertController.setValue(attributedTitle, forKey: "attributedTitle")
        alertController.setValue(attributedMessage, forKey: "attributedMessage")
        
        let option1 = UIAlertAction(title: "View Profile", style: .default) { (action) in
            print("CAFV View Profile")
        }
        option1.setValue(UIColor.systemBlue, forKey: "titleTextColor")
        
        let option2 = UIAlertAction(title: "Log out", style: .default) { (action) in
            print("CAFV Log out")
            do {
                try self.logout()
                let homePageView = LoginRouter.createModule()
                self.navigationController?.pushViewController(homePageView, animated: true)
            } catch {
                print("Error logout")
            }
        }
        option2.setValue(UIColor.red, forKey: "titleTextColor")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("CAFV Cancelar")
        }
        cancel.setValue(UIColor.systemBlue, forKey: "titleTextColor")
        
        alertController.addAction(option1)
        alertController.addAction(option2)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
}
