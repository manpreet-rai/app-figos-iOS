//
//  ProfileViewController.swift
//  Figos
//
//  Created by Manu on 02/05/21.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController {

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var personalDetailsView: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var maleBtn: CustomButton!
    @IBOutlet weak var femaleBtn: CustomButton!
    @IBOutlet weak var vegBtn: CustomButton!
    @IBOutlet weak var nonVegBtn: CustomButton!
    @IBOutlet weak var gorayaBtn: CustomButton!
    @IBOutlet weak var nakodarBtn: CustomButton!
    @IBOutlet weak var saveBtn: CustomButton!
    @IBOutlet weak var logoutBtn: CustomButton!
    @IBOutlet weak var changePasswordBtn: CustomButton!
    @IBOutlet weak var deleteBtn: CustomButton!
    
    var nameValue = "", phoneValue = "", dobValue = "", gender = "", diet = "", location = ""
    
    @objc func onResume() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.keepSynced(false)
        
        ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")").getData { (error, snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.nameValue = postDict["name"] as? String ?? ""
            self.phoneValue = postDict["phone"] as? String ?? ""
            self.dobValue = postDict["dateOfBirth"] as? String ?? ""
            self.gender = postDict["gender"] as? String ?? ""
            self.diet = postDict["diet"] as? String ?? ""
            self.location = postDict["location"] as? String ?? ""
            
            DispatchQueue.main.async {
                self.email.text = Auth.auth().currentUser?.email
                self.name.text = self.nameValue
                self.phone.text = self.phoneValue
                self.dateOfBirth.text = self.dobValue
                
                if self.gender == "Male" {
                    self.maleBtn.isSelected = true
                } else if self.gender == "Female" {
                    self.femaleBtn.isSelected = true
                }
                
                if self.diet == "Vegetarian" {
                    self.vegBtn.isSelected = true
                } else if self.diet == "Non-Vegetarian"{
                    self.nonVegBtn.isSelected = true
                }
                
                if self.location == "Goraya" {
                    self.gorayaBtn.isSelected = true
                } else if self.location == "Nakodar"{
                    self.nakodarBtn.isSelected = true
                }
                
                self.saveBtn.isEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personalDetailsView.layer.cornerRadius = 16.0
        name.attributedPlaceholder = NSAttributedString(string: "Name",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        phone.attributedPlaceholder = NSAttributedString(string: "Phone - 10 Digits",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        dateOfBirth.attributedPlaceholder = NSAttributedString(string: "DD/MM/YYYY",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        maleBtn.setBackgroundColor(color: UIColor.init(red: 217/255, green: 119/255, blue: 6/255, alpha: 1.0), forState: .highlighted)
        maleBtn.setBackgroundColor(color: UIColor.init(red: 245/255, green: 158/255, blue: 11/255, alpha: 1.0), forState: .selected)
        maleBtn.setCornerRadius(radius: 16.0)
        
        femaleBtn.setBackgroundColor(color: UIColor.init(red: 217/255, green: 119/255, blue: 6/255, alpha: 1.0), forState: .highlighted)
        femaleBtn.setBackgroundColor(color: UIColor.init(red: 245/255, green: 158/255, blue: 11/255, alpha: 1.0), forState: .selected)
        femaleBtn.setCornerRadius(radius: 16.0)
        
        vegBtn.setBackgroundColor(color: UIColor.init(red: 217/255, green: 119/255, blue: 6/255, alpha: 1.0), forState: .highlighted)
        vegBtn.setBackgroundColor(color: UIColor.init(red: 245/255, green: 158/255, blue: 11/255, alpha: 1.0), forState: .selected)
        vegBtn.setCornerRadius(radius: 16.0)
        
        nonVegBtn.setBackgroundColor(color: UIColor.init(red: 217/255, green: 119/255, blue: 6/255, alpha: 1.0), forState: .highlighted)
        nonVegBtn.setBackgroundColor(color: UIColor.init(red: 245/255, green: 158/255, blue: 11/255, alpha: 1.0), forState: .selected)
        nonVegBtn.setCornerRadius(radius: 16.0)
        
        gorayaBtn.setBackgroundColor(color: UIColor.init(red: 217/255, green: 119/255, blue: 6/255, alpha: 1.0), forState: .highlighted)
        gorayaBtn.setBackgroundColor(color: UIColor.init(red: 245/255, green: 158/255, blue: 11/255, alpha: 1.0), forState: .selected)
        gorayaBtn.setCornerRadius(radius: 16.0)
        
        nakodarBtn.setBackgroundColor(color: UIColor.init(red: 217/255, green: 119/255, blue: 6/255, alpha: 1.0), forState: .highlighted)
        nakodarBtn.setBackgroundColor(color: UIColor.init(red: 245/255, green: 158/255, blue: 11/255, alpha: 1.0), forState: .selected)
        nakodarBtn.setCornerRadius(radius: 16.0)
        
        saveBtn.setBackgroundColor(color: UIColor.init(red: 22/255, green: 163/255, blue: 74/255, alpha: 1.0), forState: .normal)
        saveBtn.setBackgroundColor(color: UIColor.init(red: 22/255, green: 128/255, blue: 61/255, alpha: 1.0), forState: .highlighted)
        saveBtn.setCornerRadius(radius: 16.0)
        
        logoutBtn.setBackgroundColor(color: UIColor.init(red: 245/255, green: 158/255, blue: 11/255, alpha: 1.0), forState: .normal)
        logoutBtn.setBackgroundColor(color: UIColor.init(red: 217/255, green: 119/255, blue: 6/255, alpha: 1.0), forState: .highlighted)
        logoutBtn.setCornerRadius(radius: 16.0)
        
        changePasswordBtn.setBackgroundColor(color: UIColor.init(red: 245/255, green: 158/255, blue: 11/255, alpha: 1.0), forState: .normal)
        changePasswordBtn.setBackgroundColor(color: UIColor.init(red: 217/255, green: 119/255, blue: 6/255, alpha: 1.0), forState: .highlighted)
        changePasswordBtn.setCornerRadius(radius: 16.0)
        
        deleteBtn.setBackgroundColor(color: .init(red: 218/255, green: 41/255, blue: 46/255, alpha: 1.0), forState: .normal)
        deleteBtn.setBackgroundColor(color: .init(red: 153/255, green: 27/255, blue: 27/255, alpha: 1.0), forState: .highlighted)
        deleteBtn.setCornerRadius(radius: 16.0)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onResume), name:
                UIApplication.willEnterForegroundNotification, object: nil)
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.keepSynced(false)
        
        ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")").getData { (error, snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.nameValue = postDict["name"] as? String ?? ""
            self.phoneValue = postDict["phone"] as? String ?? ""
            self.dobValue = postDict["dateOfBirth"] as? String ?? ""
            self.gender = postDict["gender"] as? String ?? ""
            self.diet = postDict["diet"] as? String ?? ""
            self.location = postDict["location"] as? String ?? ""
            
            DispatchQueue.main.async {
                self.email.text = Auth.auth().currentUser?.email
                self.name.text = self.nameValue
                self.phone.text = self.phoneValue
                self.dateOfBirth.text = self.dobValue
                
                if self.gender == "Male" {
                    self.maleBtn.isSelected = true
                } else if self.gender == "Female" {
                    self.femaleBtn.isSelected = true
                }
                
                if self.diet == "Vegetarian" {
                    self.vegBtn.isSelected = true
                } else if self.diet == "Non-Vegetarian"{
                    self.nonVegBtn.isSelected = true
                }
                
                if self.location == "Goraya" {
                    self.gorayaBtn.isSelected = true
                } else if self.location == "Nakodar"{
                    self.nakodarBtn.isSelected = true
                }
                
                self.saveBtn.isEnabled = true
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func maleBtnPressed(_ sender: Any) {
        if !maleBtn.isSelected {
            gender = "Male"
            maleBtn.isSelected = true
            femaleBtn.isSelected = false
        } else {
            gender = ""
            maleBtn.isSelected = false
        }
    }
    
    @IBAction func femaleBtnPressed(_ sender: Any) {
        if !femaleBtn.isSelected {
            gender = "Female"
            maleBtn.isSelected = false
            femaleBtn.isSelected = true
        } else {
            gender = ""
            femaleBtn.isSelected = false
        }
    }
    
    @IBAction func vegBtnPressed(_ sender: Any) {
        if !vegBtn.isSelected {
            diet = "Vegetarian"
            vegBtn.isSelected = true
            nonVegBtn.isSelected = false
        } else {
            diet = ""
            vegBtn.isSelected = false
        }
    }
    
    @IBAction func nonVegBtnPressed(_ sender: Any) {
        if !nonVegBtn.isSelected {
            diet = "Non-Vegetarian"
            vegBtn.isSelected = false
            nonVegBtn.isSelected = true
        } else {
            diet = ""
            nonVegBtn.isSelected = false
        }
    }
    
    @IBAction func gorayaBtnPressed(_ sender: Any) {
        if !gorayaBtn.isSelected {
            location = "Goraya"
            gorayaBtn.isSelected = true
            nakodarBtn.isSelected = false
        } else {
            location = ""
            gorayaBtn.isSelected = false
        }
    }
    
    @IBAction func nakodarBtnPressed(_ sender: Any) {
        if !nakodarBtn.isSelected {
            location = "Nakodar"
            gorayaBtn.isSelected = false
            nakodarBtn.isSelected = true
        } else {
            location = ""
            nakodarBtn.isSelected = false
        }
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        nameValue = name.text ?? ""
        phoneValue = phone.text ?? ""
        dobValue = dateOfBirth.text ?? ""
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/name").setValue(nameValue)
        ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/dateOfBirth").setValue(dobValue)
        ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/gender").setValue(gender)
        ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/diet").setValue(diet)
        ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/location").setValue(location)
        ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/phone").setValue(phoneValue)
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            showToast(message: "Logged Out Successfully")
            self.present((self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC"))!, animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func changePasswordBtnPressed(_ sender: Any) {
        self.showToast(message: "Use Logout & Click Forgot Password")
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.keepSynced(false)
        
        let epoch = Int(Date().timeIntervalSince1970*1000)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .long
        let datetime = formatter.string(from: Date())
        
        ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/userDeactivateRequest").setValue("YES")
        ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/userDeactivateRequestAt").setValue(datetime)
        ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/userDeactivateRequestTimestamp").setValue(epoch)
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            showToast(message: "Account Deactivated Successfully")
            self.present((self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC"))!, animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
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
