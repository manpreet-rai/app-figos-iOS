//
//  ViewController.swift
//  Figos
//
//  Created by Manu on 17/04/21.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var pageTitle: UILabel!
    
    @IBOutlet weak var loginView: UIStackView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var forgotPasswordBtn: CustomButton!
    @IBOutlet weak var proceedBtn: CustomButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var signUpBtn: CustomButton!
    
    @IBOutlet weak var registerView: UIStackView!
    @IBOutlet weak var registerEmail: UITextField!
    @IBOutlet weak var registerPassword: UITextField!
    @IBOutlet weak var confirmRegisterPassword: UITextField!
    @IBOutlet weak var registerEmailView: UIView!
    @IBOutlet weak var registerPasswordView: UIView!
    @IBOutlet weak var registerConfirmPasswordView: UIView!
    
    @IBOutlet weak var forgotPasswordView: UIStackView!
    @IBOutlet weak var forgotEmail: UITextField!
    @IBOutlet weak var forgotPasswordEmailView: UIView!
    
    @IBOutlet weak var skipBtn: CustomButton!
    var mode = "login"

    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.present((self.storyboard?.instantiateViewController(withIdentifier: "HomeVC"))!, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        emailView.layer.cornerRadius = 16.0
        passwordView.layer.cornerRadius = 16.0
        registerEmailView.layer.cornerRadius = 16.0
        registerPasswordView.layer.cornerRadius = 16.0
        registerConfirmPasswordView.layer.cornerRadius = 16.0
        forgotPasswordEmailView.layer.cornerRadius = 16.0
        
        email.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        registerEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        registerPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        confirmRegisterPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        forgotEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        
        proceedBtn.setBackgroundColor(color: .init(red: 218/255, green: 41/255, blue: 46/255, alpha: 1.0), forState: .normal)
        proceedBtn.setBackgroundColor(color: .init(red: 153/255, green: 27/255, blue: 27/255, alpha: 1.0), forState: .highlighted)
        proceedBtn.setCornerRadius(radius: 16.0)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func proceedBtn(_ sender: CustomButton) {
        if mode=="login" {
            guard let emailEntered = email.text, !emailEntered.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                showToast(message: "Email cannot be empty")
                return
            }
            
            guard let passwordEntered = password.text, !passwordEntered.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                showToast(message: "Password cannot be empty")
                return
            }
            
            Auth.auth().signIn(withEmail: emailEntered, password: passwordEntered) { [weak self] authResult, error in
                if error != nil {
                    if let errCode = AuthErrorCode(rawValue: error!._code) {
                        switch errCode {
                        case .invalidEmail:
                            self?.showToast(message: "Invalid Email")
                        case .wrongPassword:
                            self?.showToast(message: "Invalid Password")
                        default:
                            self?.showToast(message: "Error Occured, Retry Later")
                        }
                    }
                    return
                }
                self?.present((self?.storyboard?.instantiateViewController(withIdentifier: "HomeVC"))!, animated: true)
            }
        } else if mode=="register" {
            guard let emailEntered = registerEmail.text, !emailEntered.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                showToast(message: "Email cannot be empty")
                return
            }
            
            guard let passwordEntered = registerPassword.text, !passwordEntered.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                showToast(message: "Password cannot be empty")
                return
            }
            
            guard let confirmPasswordEntered = confirmRegisterPassword.text, !confirmPasswordEntered.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                showToast(message: "Confirm password is empty")
                return
            }
            
            if passwordEntered.count < 6 {
                showToast(message: "Password length must be more than 6")
                return
            }
            
            if passwordEntered != confirmPasswordEntered {
                showToast(message: "Passwords does not match, Retry")
                return
            }
            
            Auth.auth().createUser(withEmail: emailEntered, password: passwordEntered) { authResult, error in
                if error != nil {
                    print(error.debugDescription)
                    if let errCode = AuthErrorCode(rawValue: error!._code) {
                        switch errCode {
                        case .invalidEmail:
                            self.showToast(message: "Invalid Email")
                        case .emailAlreadyInUse:
                            self.showToast(message: "Email Already Registered")
                        default:
                            self.showToast(message: "Error Occured, Retry Later")
                        }
                    }
                    return
                }
                
                let epoch = Int(Date().timeIntervalSince1970*1000)
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .long
                let datetime = formatter.string(from: Date())
                
                var ref: DatabaseReference!
                ref = Database.database().reference()
                
                ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/userCreatedAt").setValue(datetime)
                ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/userCreatedTimestamp").setValue(epoch)
                ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/token").setValue("iOS")

                self.present((self.storyboard?.instantiateViewController(withIdentifier: "HomeVC"))!, animated: true)
            }
        } else {
            guard let emailEntered = forgotEmail.text, !emailEntered.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                showToast(message: "Email cannot be empty")
                return
            }
            
            Auth.auth().sendPasswordReset(withEmail: emailEntered) { error in
                if error != nil {
                    print(error.debugDescription)
                    if let errCode = AuthErrorCode(rawValue: error!._code) {
                        switch errCode {
                        case .invalidEmail:
                            self.showToast(message: "Invalid Email")
                        default:
                            self.showToast(message: "Error Occured, Retry Later")
                        }
                    }
                    return
                }
                self.showToast(message: "Password Reset Email Sent, Check!")
            }
            
            mode = "login"
            pageTitle.text = "Login"
            loginView.isHidden = false
            forgotPasswordView.isHidden = true
            signUpBtn.setTitle("Have Account? Sign In", for:.normal)
        }
    }

    @IBAction func forgotPasswordBtnPressed(_ sender: Any) {
        mode = "forgot"
        pageTitle.text = "Forgot Password"
        loginView.isHidden = true
        forgotPasswordView.isHidden = false
        signUpBtn.setTitle("Got Password? Login", for:.normal)
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        if mode=="login" {
            mode = "register"
            pageTitle.text = "Register"
            loginView.isHidden = true
            registerView.isHidden = false
            signUpBtn.setTitle("Have Account? Sign In", for:.normal)
        } else if mode=="register" {
            mode = "login"
            pageTitle.text = "Login"
            loginView.isHidden = false
            registerView.isHidden = true
            signUpBtn.setTitle("No Account? Sign Up", for:.normal)
        } else {
            mode = "login"
            pageTitle.text = "Login"
            loginView.isHidden = false
            forgotPasswordView.isHidden = true
            signUpBtn.setTitle("Have Account? Sign In", for:.normal)
        }
    }
    
    @IBAction func skipBtnPressed(_ sender: Any) {
        self.present((self.storyboard?.instantiateViewController(withIdentifier: "HomeVC"))!, animated: true)
    }
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.black
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Blinker", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.95
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
