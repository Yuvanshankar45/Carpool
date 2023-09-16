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
    let activityIndicator = UIActivityIndicatorView()
    
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
        guard let enteredEmail = ibEmailTextField.text else { return }

        guard isValidEmail(email: enteredEmail) else {
            alterMessageWithTitle(message: "Please enter the valid email id")
            return
        }

        guard let password = ibPasswordTextField.text else {
            self.alterMessageWithTitle(message: "Please enter the password", title: "Error")
            return
        }

        let validationMessages = validatePassword(password)

        if validationMessages.isEmpty {
            print("Password is valid")
            loginUser()
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
    
    func pushHomePage() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "TabBar")
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    func loginUser() {
        DispatchQueue.main.async {
            self.activityIndicator.startIndicator(in: self.view)
        }
        let urlString = "https://4eca-122-172-86-117.ngrok-free.app/api/user/login"
        let requestBody =   [
            "email": ibEmailTextField.text ?? "",
            "password": ibPasswordTextField.text ?? ""
        ]

        NetworkManager.shared.postRequest(urlString: urlString, parameters: requestBody) { [weak self] result in
            switch result {
            case .success(let data):
                // Process the POST response data here
                do {
                    let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                    print("Received data: \(response)")
                    UserStorage.accessToken = response.data?.accessToken ?? ""
                    UserStorage.isLoggedIn = true
                    
                    if response.success ?? false {
                        DispatchQueue.main.async {
                            self?.activityIndicator.stopIndicator()
                        }
                        self?.pushHomePage()
                    } else {
                        self?.alterMessageWithTitle(message: response.error ?? "", title: "Error")
                        self?.activityIndicator.stopIndicator()
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.activityIndicator.stopIndicator()
                    }
                    self?.alterMessageWithTitle(message: "Internal Server Error", title: "Error")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.activityIndicator.stopIndicator()
                }
                self?.alterMessageWithTitle(message: "Internal Server Error", title: "Error")
                print("Error: \(error)")
            }
        }
    }
    
}
