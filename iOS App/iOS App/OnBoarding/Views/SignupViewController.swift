//
//  SignupViewController.swift
//  MedBook
//
//  Created by Yuvan Shankar on 08/08/23.
//

import UIKit

class SignupViewController: UIViewController {
    
    // Outlet Properties
    @IBOutlet weak var ibEmailTextField: BottomLineTextField!
    @IBOutlet weak var ibPasswordTextField: BottomLineTextField!
    @IBOutlet weak var ibNameTextField: BottomLineTextField!
    @IBOutlet weak var ibPhoneNoTextField: BottomLineTextField!
    @IBOutlet weak var ibAddressTextField: BottomLineTextField!
    @IBOutlet weak var ibLetsGoBtnHolderView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuretheView()
        configureViewGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - IB Actions
    @IBAction func tappedOnLetsGoButton(_ sender: UIButton) {
        
        if ibNameTextField.text == "" {
            self.alterMessageWithTitle(message: "Please enter name", title: "Error")
            return
        }
        
//        guard let name = (ibNameTextField.text != nil), let name = ibNameTextField != "" else  {
//            self.alterMessageWithTitle(message: "Please enter name", title: "Error")
//            return
//        }
    
        guard let enteredEmail = ibEmailTextField.text else { return }
        
        guard isValidEmail(email: enteredEmail) else {
            alterMessageWithTitle(message: "Please enter the valid email id")
            return
        }
        
        guard let password = ibPasswordTextField.text else {
            self.alterMessageWithTitle(message: "Please enter the password", title: "Error")
            return
        }
        
        if ibPhoneNoTextField.text == "" {
            self.alterMessageWithTitle(message: "Please enter the phone no", title: "Error")
            return
        }
        
        if ibPhoneNoTextField.text?.count ?? 0 < 10 {
            self.alterMessageWithTitle(message: "Please enter valid phone no", title: "Error")
            return
        }
        
        if ibAddressTextField.text == "" {
            self.alterMessageWithTitle(message: "Please enter the address", title: "Error")
            return
        }
        
        let validationMessages = validatePassword(password)
        
        if validationMessages.isEmpty {
            print("Password is valid")
          
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let loginVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
//            self.navigationController?.pushViewController(loginVC, animated: true)
            
        } else {
            for message in validationMessages {
                print(message)
                // Update UI to display each validation error message
                alterMessageWithTitle(message: "\(message)", title: "Error")
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - Private Methods
private extension SignupViewController {
    
    func isValidEmail(email: String) -> Bool {
        // Regular expression pattern to validate email format
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> [String] {
        var validationMessages: [String] = []
        
        if password.count < 8 {
            validationMessages.append("Password must be at least 8 characters long")
        }
        
        let uppercaseRegex = ".*[A-Z].*"
        if !NSPredicate(format: "SELF MATCHES %@", uppercaseRegex).evaluate(with: password) {
            validationMessages.append("Password must contain at least one uppercase letter")
        }
        
        let specialCharRegex = ".*[!@#$%^&*()_+\\-=\\[\\]{};':\",./<>?].*"
        if !NSPredicate(format: "SELF MATCHES %@", specialCharRegex).evaluate(with: password) {
            validationMessages.append("Password must contain at least one special character")
        }
        
        return validationMessages
    }

    func configuretheView() {
        [ibEmailTextField, ibPasswordTextField, ibNameTextField, ibPhoneNoTextField, ibAddressTextField].forEach { txtField in
            txtField?.delegate = self
            txtField?.bottomLineColor = UIColor("#B5B5B5")
            txtField?.bottomLineWidth = 2.0
        }
        
        ibLetsGoBtnHolderView.layer.cornerRadius = 12
        ibLetsGoBtnHolderView.layer.borderWidth = 1
        ibLetsGoBtnHolderView.layer.borderColor = UIColor("0A0A0A").cgColor
        
    }
    
    func configureViewGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}

//MARK: - API Request
private extension SignupViewController {
}

//MARK: - TextField Delegate
extension SignupViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
