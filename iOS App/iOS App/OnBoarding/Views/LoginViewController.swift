//
//  LoginViewController.swift
//  MedBook
//
//  Created by Yuvan Shankar on 08/08/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    // Outlet properties
    @IBOutlet weak var ibEmailTextField: BottomLineTextField!
    @IBOutlet weak var ibPasswordTextField: BottomLineTextField!
    @IBOutlet weak var ibLoginBtnHolderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        configureViewGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    //MARK: - IB Actions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - Private Methods
private extension LoginViewController {
    
    func isValidEmail(email: String) -> Bool {
        // Regular expression pattern to validate email format
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func configureViewGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureView() {
        ibEmailTextField.bottomLineColor = UIColor("#B5B5B5")
        ibEmailTextField.bottomLineWidth = 2.0
        
        ibPasswordTextField.bottomLineColor = UIColor("#B5B5B5")
        ibPasswordTextField.bottomLineWidth = 2.0
        
        ibLoginBtnHolderView.layer.cornerRadius = 12
        ibLoginBtnHolderView.layer.borderWidth = 1
        ibLoginBtnHolderView.layer.borderColor = UIColor("0A0A0A").cgColor
    }
}
