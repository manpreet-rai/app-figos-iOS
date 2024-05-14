//
//  AboutUsViewController.swift
//  Figos
//
//  Created by Manu on 01/05/21.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var aboutUsBtn: CustomButton!
    @IBOutlet weak var ourLocationsBtn: CustomButton!
    @IBOutlet weak var beOurPartnerBtn: CustomButton!
    @IBOutlet weak var aboutUsImage: UIImageView!
    @IBOutlet weak var readMoreBtn: CustomButton!
    
    @IBOutlet weak var showItemListsBtn: CustomButton!
    @IBOutlet weak var gorayaMenuBtn: CustomButton!
    @IBOutlet weak var nakodarMenuBtn: CustomButton!
    
    @IBOutlet weak var gorayaAddressLabel: UILabel!
    @IBOutlet weak var nakodarAddressLabel: UILabel!
    @IBOutlet weak var gorayaMapsBtn: CustomButton!
    @IBOutlet weak var nakodarMapsBtn: CustomButton!
    @IBOutlet weak var getInvoledBtn: CustomButton!
    
    @IBOutlet weak var aboutUsView: UIStackView!
    @IBOutlet weak var locationView: UIStackView!
    @IBOutlet weak var getInvolvedView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutUsImage.layer.cornerRadius = 16.0
        
        showItemListsBtn.setBackgroundColor(color: UIColor.init(red: 52/255, green: 55/255, blue: 60/255, alpha: 1.0), forState: .normal)
        showItemListsBtn.setBackgroundColor(color: UIColor.init(red: 127/255, green: 29/255, blue: 29/255, alpha: 1.0), forState: .highlighted)
        showItemListsBtn.setCornerRadius(radius: 16.0)
        
        gorayaMenuBtn.setBackgroundColor(color: UIColor.init(red: 52/255, green: 55/255, blue: 60/255, alpha: 1.0), forState: .normal)
        gorayaMenuBtn.setBackgroundColor(color: UIColor.init(red: 127/255, green: 29/255, blue: 29/255, alpha: 1.0), forState: .highlighted)
        gorayaMenuBtn.setCornerRadius(radius: 16.0)
        
        nakodarMenuBtn.setBackgroundColor(color: UIColor.init(red: 52/255, green: 55/255, blue: 60/255, alpha: 1.0), forState: .normal)
        nakodarMenuBtn.setBackgroundColor(color: UIColor.init(red: 127/255, green: 29/255, blue: 29/255, alpha: 1.0), forState: .highlighted)
        nakodarMenuBtn.setCornerRadius(radius: 16.0)
        
        aboutUsBtn.setBackgroundColor(color: UIColor.init(red: 52/255, green: 55/255, blue: 60/255, alpha: 1.0), forState: .normal)
        aboutUsBtn.setBackgroundColor(color: UIColor.init(red: 127/255, green: 29/255, blue: 29/255, alpha: 1.0), forState: .highlighted)
        aboutUsBtn.setBackgroundColor(color: UIColor.init(red: 127/255, green: 29/255, blue: 29/255, alpha: 1.0), forState: .selected)
        aboutUsBtn.setCornerRadius(radius: 16.0)
        aboutUsBtn.isSelected = true
        
        ourLocationsBtn.setBackgroundColor(color: UIColor.init(red: 52/255, green: 55/255, blue: 60/255, alpha: 1.0), forState: .normal)
        ourLocationsBtn.setBackgroundColor(color: UIColor.init(red: 127/255, green: 29/255, blue: 29/255, alpha: 1.0), forState: .highlighted)
        ourLocationsBtn.setBackgroundColor(color: UIColor.init(red: 127/255, green: 29/255, blue: 29/255, alpha: 1.0), forState: .selected)
        ourLocationsBtn.setCornerRadius(radius: 16.0)
        
        beOurPartnerBtn.setBackgroundColor(color: UIColor.init(red: 52/255, green: 55/255, blue: 60/255, alpha: 1.0), forState: .normal)
        beOurPartnerBtn.setBackgroundColor(color: UIColor.init(red: 127/255, green: 29/255, blue: 29/255, alpha: 1.0), forState: .highlighted)
        beOurPartnerBtn.setBackgroundColor(color: UIColor.init(red: 127/255, green: 29/255, blue: 29/255, alpha: 1.0), forState: .selected)
        beOurPartnerBtn.setCornerRadius(radius: 16.0)
        
        readMoreBtn.setBackgroundColor(color: UIColor.init(red: 21/255, green: 128/255, blue: 61/255, alpha: 1.0), forState: .normal)
        readMoreBtn.setBackgroundColor(color: UIColor.init(red: 20/255, green: 83/255, blue: 45/255, alpha: 1.0), forState: .highlighted)
        readMoreBtn.setCornerRadius(radius: 16.0)
        
        gorayaAddressLabel.text = "D18–22 Rupal Market\nRurka Jandiala Road\nGoraya Punjab 144409\nManager – Raman Kumar\n+91 81465–49183"
        nakodarAddressLabel.text = "Shankar Road Near Samra\nOffice Kalar Nagar\nNakodar Punjab 144040\nManager – Randeep Singh Bassi\n+91 98551–55811"
        
        gorayaMapsBtn.setBackgroundColor(color: UIColor.init(red: 21/255, green: 94/255, blue: 117/255, alpha: 1.0), forState: .normal)
        gorayaMapsBtn.setBackgroundColor(color: UIColor.init(red: 22/255, green: 78/255, blue: 99/255, alpha: 1.0), forState: .highlighted)
        gorayaMapsBtn.setCornerRadius(radius: 16.0)
        
        nakodarMapsBtn.setBackgroundColor(color: UIColor.init(red: 21/255, green: 94/255, blue: 117/255, alpha: 1.0), forState: .normal)
        nakodarMapsBtn.setBackgroundColor(color: UIColor.init(red: 22/255, green: 78/255, blue: 99/255, alpha: 1.0), forState: .highlighted)
        nakodarMapsBtn.setCornerRadius(radius: 16.0)
        
        getInvoledBtn.setBackgroundColor(color: UIColor.init(red: 21/255, green: 128/255, blue: 61/255, alpha: 1.0), forState: .normal)
        getInvoledBtn.setBackgroundColor(color: UIColor.init(red: 20/255, green: 83/255, blue: 45/255, alpha: 1.0), forState: .highlighted)
        getInvoledBtn.setCornerRadius(radius: 16.0)
        
    }
    
    @IBAction func showItemListsBtnPressed(_ sender: Any) {
        gorayaMenuBtn.isHidden = false
        nakodarMenuBtn.isHidden = false
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
    @IBAction func aboutUsBtnPressed(_ sender: Any) {
        if !aboutUsBtn.isSelected {
            aboutUsBtn.isSelected = true
            ourLocationsBtn.isSelected = false
            beOurPartnerBtn.isSelected = false
            
            aboutUsView.isHidden = false
            locationView.isHidden = true
            getInvolvedView.isHidden = true
        }
    }
    
    @IBAction func ourLocationsBtnPressed(_ sender: Any) {
        if !ourLocationsBtn.isSelected {
            aboutUsBtn.isSelected = false
            ourLocationsBtn.isSelected = true
            beOurPartnerBtn.isSelected = false
            
            aboutUsView.isHidden = true
            locationView.isHidden = false
            getInvolvedView.isHidden = true
        }
    }
    
    @IBAction func beOurPartnerBtnPressed(_ sender: Any) {
        if !beOurPartnerBtn.isSelected {
            aboutUsBtn.isSelected = false
            ourLocationsBtn.isSelected = false
            beOurPartnerBtn.isSelected = true
            
            aboutUsView.isHidden = true
            locationView.isHidden = true
            getInvolvedView.isHidden = false
        }
    }
    
    @IBAction func readMoreBtnPressed(_ sender: Any) {
        guard let url = URL(string: "https://figos.in/about-us/") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func gorayaMapsBtnPressed(_ sender: Any) {
        guard let url = URL(string: "https://www.google.com/maps/search/?api=1&query=31.123841,75.769625") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func nakodarMapsBtnPressed(_ sender: Any) {
        guard let url = URL(string: "https://www.google.com/maps/search/?api=1&query=31.128995,75.485179") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func getInvolvedBtnPressed(_ sender: Any) {
        guard let url = URL(string: "https://figos.in/get-franchise/") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
