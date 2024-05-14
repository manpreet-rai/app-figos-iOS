//
//  SecondViewController.swift
//  Figos
//
//  Created by Manu on 17/04/21.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {
        
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var aboutUsBtn: UIButton!
    @IBOutlet weak var gorayaMenuBtn: CustomButton!
    @IBOutlet weak var nakodarMenuBtn: CustomButton!
    @IBOutlet weak var dailyOfferView: UIView!
    @IBOutlet weak var dailyOfferImage: UIImageView!
    @IBOutlet weak var dailyCallUsBtn: CustomButton!
    @IBOutlet weak var dailyOrderNowBtn: CustomButton!
    @IBOutlet weak var specialOfferView: UIView!
    @IBOutlet weak var specialOfferImage: UIImageView!
    @IBOutlet weak var specialCallUsBtn: CustomButton!
    @IBOutlet weak var specialOrderNowBtn: CustomButton!
    @IBOutlet weak var dailyOfferAboutUsLabel: UILabel!
    @IBOutlet weak var specialOfferAboutUs: UILabel!
    
    @objc func onResume() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.keepSynced(false)
        
        if Auth.auth().currentUser != nil {
            let epoch = Int(Date().timeIntervalSince1970*1000)
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .long
            let datetime = formatter.string(from: Date())
            
            ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/userLastLoginAt").setValue(datetime)
            ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/userLastLoginTimestamp").setValue(epoch)
            
            profileBtn.isHidden = false
            
            ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")").getData { (error, snapshot) in
                let postDict = snapshot.value as? [String : AnyObject] ?? [:]
                if postDict["location"] != nil {
                    if postDict["location"] as! String == "Goraya"{
                        ref.child("offers/gorayaOffer").getData { (error, snapshot) in
                            let url = snapshot.value as! String
                            
                            DispatchQueue.main.async {
                                self.dailyOfferImage.downloaded(from: url)
                            }
                        }
                        
                        if postDict["special"] != nil {
                            ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/special").getData { (error, snapshot) in
                                let url = snapshot.value as! String
                                
                                DispatchQueue.main.async {
                                    self.specialOfferImage.downloaded(from: url)
                                    self.specialOfferView.isHidden = false
                                    self.dailyOfferAboutUsLabel.isHidden = true
                                    self.specialOfferAboutUs.isHidden = false
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.specialOfferView.isHidden = true
                                self.dailyOfferAboutUsLabel.isHidden = false
                                self.specialOfferAboutUs.isHidden = true
                            }
                        }
                    }
                    else if postDict["location"] as! String == "Nakodar"{
                        ref.child("offers/nakodarOffer").getData { (error, snapshot) in
                            let url = snapshot.value as! String
                            
                            DispatchQueue.main.async {
                                self.dailyOfferImage.downloaded(from: url)
                            }
                        }
                        
                        if postDict["special"] != nil {
                            ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/special").getData { (error, snapshot) in
                                let url = snapshot.value as! String
                                
                                DispatchQueue.main.async {
                                    self.specialOfferImage.downloaded(from: url)
                                    self.specialOfferView.isHidden = false
                                    self.dailyOfferAboutUsLabel.isHidden = true
                                    self.specialOfferAboutUs.isHidden = false
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.specialOfferView.isHidden = true
                                self.dailyOfferAboutUsLabel.isHidden = false
                                self.specialOfferAboutUs.isHidden = true
                            }
                        }
                    }
                }
                else if postDict["special"] != nil {
                    ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/special").getData { (error, snapshot) in
                        let url = snapshot.value as! String
                        
                        DispatchQueue.main.async {
                            self.dailyOfferImage.downloaded(from: url)
                            self.specialOfferView.isHidden = true
                            self.dailyOfferAboutUsLabel.isHidden = false
                            self.specialOfferAboutUs.isHidden = true
                        }
                    }
                } else {
                    ref.child("offers/gorayaOnly").getData { (error, snapshot) in
                        let url = snapshot.value as! String
                        
                        DispatchQueue.main.async {
                            self.dailyOfferImage.downloaded(from: url)
                        }
                    }
                    
                    ref.child("offers/nakodarOnly").getData { (error, snapshot) in
                        let url = snapshot.value as! String
                        
                        DispatchQueue.main.async {
                            self.specialOfferImage.downloaded(from: url)
                            self.specialOfferView.isHidden = false
                            self.dailyOfferAboutUsLabel.isHidden = true
                            self.specialOfferAboutUs.isHidden = false
                        }
                    }
                }
            }
        } else {
            loginBtn.isHidden = false
            
            ref.child("offers/gorayaOnly").getData { (error, snapshot) in
                let url = snapshot.value as! String
                
                DispatchQueue.main.async {
                    self.dailyOfferImage.downloaded(from: url)
                }
            }
            
            ref.child("offers/nakodarOnly").getData { (error, snapshot) in
                let url = snapshot.value as! String
                
                DispatchQueue.main.async {
                    self.specialOfferImage.downloaded(from: url)
                    self.specialOfferView.isHidden = false
                    self.dailyOfferAboutUsLabel.isHidden = true
                    self.specialOfferAboutUs.isHidden = false
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gorayaMenuBtn.setBackgroundColor(color: UIColor.init(red: 52/255, green: 55/255, blue: 60/255, alpha: 1.0), forState: .normal)
        gorayaMenuBtn.setBackgroundColor(color: UIColor.init(red: 127/255, green: 29/255, blue: 29/255, alpha: 1.0), forState: .highlighted)
        gorayaMenuBtn.setCornerRadius(radius: 16.0)
        
        nakodarMenuBtn.setBackgroundColor(color: UIColor.init(red: 52/255, green: 55/255, blue: 60/255, alpha: 1.0), forState: .normal)
        nakodarMenuBtn.setBackgroundColor(color: UIColor.init(red: 127/255, green: 29/255, blue: 29/255, alpha: 1.0), forState: .highlighted)
        nakodarMenuBtn.setCornerRadius(radius: 16.0)
        
        dailyOfferView.layer.cornerRadius = 16.0
        specialOfferView.layer.cornerRadius = 16.0
        
        dailyCallUsBtn.setBackgroundColor(color: UIColor.init(red: 22/255, green: 163/255, blue: 74/255, alpha: 1.0), forState: .normal)
        dailyCallUsBtn.setBackgroundColor(color: UIColor.init(red: 22/255, green: 128/255, blue: 61/255, alpha: 1.0), forState: .highlighted)
        dailyCallUsBtn.setCornerRadius(radius: 16.0)
        
        dailyOrderNowBtn.setBackgroundColor(color: UIColor.init(red: 245/255, green: 158/255, blue: 11/255, alpha: 1.0), forState: .normal)
        dailyOrderNowBtn.setBackgroundColor(color: UIColor.init(red: 217/255, green: 119/255, blue: 6/255, alpha: 1.0), forState: .highlighted)
        dailyOrderNowBtn.setCornerRadius(radius: 16.0)
        
        specialCallUsBtn.setBackgroundColor(color: UIColor.init(red: 22/255, green: 163/255, blue: 74/255, alpha: 1.0), forState: .normal)
        specialCallUsBtn.setBackgroundColor(color: UIColor.init(red: 22/255, green: 128/255, blue: 61/255, alpha: 1.0), forState: .highlighted)
        specialCallUsBtn.setCornerRadius(radius: 16.0)
        
        specialOrderNowBtn.setBackgroundColor(color: UIColor.init(red: 245/255, green: 158/255, blue: 11/255, alpha: 1.0), forState: .normal)
        specialOrderNowBtn.setBackgroundColor(color: UIColor.init(red: 217/255, green: 119/255, blue: 6/255, alpha: 1.0), forState: .highlighted)
        specialOrderNowBtn.setCornerRadius(radius: 16.0)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
            
        NotificationCenter.default.addObserver(self, selector: #selector(onResume), name:
                UIApplication.willEnterForegroundNotification, object: nil)
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.keepSynced(false)
        
        if Auth.auth().currentUser != nil {
            let epoch = Int(Date().timeIntervalSince1970*1000)
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .long
            let datetime = formatter.string(from: Date())
            
            ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/userLastLoginAt").setValue(datetime)
            ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/userLastLoginTimestamp").setValue(epoch)
            
            profileBtn.isHidden = false
            
            ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")").getData { (error, snapshot) in
                let postDict = snapshot.value as? [String : AnyObject] ?? [:]
                if postDict["location"] != nil {
                    if postDict["location"] as! String == "Goraya"{
                        ref.child("offers/gorayaOffer").getData { (error, snapshot) in
                            let url = snapshot.value as! String
                            
                            DispatchQueue.main.async {
                                self.dailyOfferImage.downloaded(from: url)
                            }
                        }
                        
                        if postDict["special"] != nil {
                            ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/special").getData { (error, snapshot) in
                                let url = snapshot.value as! String
                                
                                DispatchQueue.main.async {
                                    self.specialOfferImage.downloaded(from: url)
                                    self.specialOfferView.isHidden = false
                                    self.dailyOfferAboutUsLabel.isHidden = true
                                    self.specialOfferAboutUs.isHidden = false
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.specialOfferView.isHidden = true
                                self.dailyOfferAboutUsLabel.isHidden = false
                                self.specialOfferAboutUs.isHidden = true
                            }
                        }
                    }
                    else if postDict["location"] as! String == "Nakodar"{
                        ref.child("offers/nakodarOffer").getData { (error, snapshot) in
                            let url = snapshot.value as! String
                            
                            DispatchQueue.main.async {
                                self.dailyOfferImage.downloaded(from: url)
                            }
                        }
                        
                        if postDict["special"] != nil {
                            ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/special").getData { (error, snapshot) in
                                let url = snapshot.value as! String
                                
                                DispatchQueue.main.async {
                                    self.specialOfferImage.downloaded(from: url)
                                    self.specialOfferView.isHidden = false
                                    self.dailyOfferAboutUsLabel.isHidden = true
                                    self.specialOfferAboutUs.isHidden = false
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.specialOfferView.isHidden = true
                                self.dailyOfferAboutUsLabel.isHidden = false
                                self.specialOfferAboutUs.isHidden = true
                            }
                        }
                    }
                }
                else if postDict["special"] != nil {
                    ref.child("users/\(Auth.auth().currentUser?.uid ?? "default")/special").getData { (error, snapshot) in
                        let url = snapshot.value as! String
                        
                        DispatchQueue.main.async {
                            self.dailyOfferImage.downloaded(from: url)
                            self.specialOfferView.isHidden = true
                            self.dailyOfferAboutUsLabel.isHidden = false
                            self.specialOfferAboutUs.isHidden = true
                        }
                    }
                } else {
                    ref.child("offers/gorayaOnly").getData { (error, snapshot) in
                        let url = snapshot.value as! String
                        
                        DispatchQueue.main.async {
                            self.dailyOfferImage.downloaded(from: url)
                        }
                    }
                    
                    ref.child("offers/nakodarOnly").getData { (error, snapshot) in
                        let url = snapshot.value as! String
                        
                        DispatchQueue.main.async {
                            self.specialOfferImage.downloaded(from: url)
                            self.specialOfferView.isHidden = false
                            self.dailyOfferAboutUsLabel.isHidden = true
                            self.specialOfferAboutUs.isHidden = false
                        }
                    }
                }
            }
        } else {
            loginBtn.isHidden = false
            
            ref.child("offers/gorayaOnly").getData { (error, snapshot) in
                let url = snapshot.value as! String
                
                DispatchQueue.main.async {
                    self.dailyOfferImage.downloaded(from: url)
                }
            }
            
            ref.child("offers/nakodarOnly").getData { (error, snapshot) in
                let url = snapshot.value as! String
                
                DispatchQueue.main.async {
                    self.specialOfferImage.downloaded(from: url)
                    self.specialOfferView.isHidden = false
                    self.dailyOfferAboutUsLabel.isHidden = true
                    self.specialOfferAboutUs.isHidden = false
                }
            }
        }
    }
    
    @IBAction func dailyCallBtnPressed(_ sender: CustomButton) {
                guard let phone = URL(string: "tel://+918146549183") else { return }
                UIApplication.shared.open(phone, options: [:], completionHandler: nil)
    }
            
    @IBAction func dailyOrderBtnPressed(_ sender: CustomButton) {
                guard let url = URL(string: "https://fk.petpooja.com/") else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func specialCallUsBtnPressed(_ sender: Any) {
        guard let phone = URL(string: "tel://+918146549183") else { return }
        UIApplication.shared.open(phone, options: [:], completionHandler: nil)
    }
    
    @IBAction func specialOrderBtnPressed(_ sender: Any) {
        guard let url = URL(string: "https://fk.petpooja.com/") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func profileBtnPressed(_ sender: Any) {
        self.present((self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC"))!, animated: true)
    }
    
    @IBAction func aboutUsBtnPressed(_ sender: Any) {
        self.present((self.storyboard?.instantiateViewController(withIdentifier: "AboutUsVC"))!, animated: true)
    }
    
    @IBAction func gorayaMenuPressed(_ sender: Any) {
        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuViewController
        menuVC.restID = "03cixh8r"
        self.present(menuVC, animated: true)
    }
    
    @IBAction func nakodarMenuPressed(_ sender: Any) {
        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuViewController
        menuVC.restID = "s2xuy4v5"
        self.present(menuVC, animated: true)
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

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
