//
//  ViewController.swift
//  iOS App
//
//  Created by Yuvan Shankar on 16/09/2023.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var ibSignupButton: UIButton!
    @IBOutlet weak var ibLoginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
    
        ibSignupButton.layer.cornerRadius = 12
        ibSignupButton.layer.borderWidth = 1
        ibSignupButton.layer.borderColor = UIColor("0A0A0A").cgColor
        
        ibLoginButton.layer.cornerRadius = 12
        ibLoginButton.layer.borderWidth = 1
        ibLoginButton.layer.borderColor = UIColor("0A0A0A").cgColor
    }
}

//MARK: - IB Actions
private extension LandingViewController {
    
    @IBAction func tappedOnSignupButton(_ sender: UIButton) {
        pushSignupVC()
    }
    
    @IBAction func tappedOnLoginButton(_ sender: UIButton) {
        pushLoginVC()
    }
}

//MARK: - Navigation methods
private extension LandingViewController {
    func pushSignupVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signupVC = storyboard.instantiateViewController(withIdentifier: "SignupViewController")
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    func pushLoginVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}
