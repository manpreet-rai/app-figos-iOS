//
//  MenuViewController.swift
//  Figos
//
//  Created by Manu on 07/06/21.
//

import UIKit
import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let success, message: String
    let restaurants: [Restaurant]
    let ordertypes: [Ordertype]
    let categories: [Category]
    let parentcategories: [JSONAny]
    let items: [Item]
    let variations: [WelcomeVariation]
    let addongroups: [Addongroup]
    let attributes: [Attribute]
    let discounts, taxes: [JSONAny]
    let serverdatetime, dbVersion, applicationVersion: String
    let httpCode: Int
    
    enum CodingKeys: String, CodingKey {
        case success, message, restaurants, ordertypes, categories, parentcategories, items, variations, addongroups, attributes, discounts, taxes, serverdatetime
        case dbVersion = "db_version"
        case applicationVersion = "application_version"
        case httpCode = "http_code"
    }
}

// MARK: - Addongroup
struct Addongroup: Codable {
    let addongroupid, addongroupRank, active: String
    let addongroupitems: [Addongroupitem]
    let addongroupName: String
    
    enum CodingKeys: String, CodingKey {
        case addongroupid
        case addongroupRank = "addongroup_rank"
        case active, addongroupitems
        case addongroupName = "addongroup_name"
    }
}

// MARK: - Addongroupitem
struct Addongroupitem: Codable {
    let addonitemid, addonitemName, addonitemPrice, active: String
    let attributes, addonitemRank: String
    
    enum CodingKeys: String, CodingKey {
        case addonitemid
        case addonitemName = "addonitem_name"
        case addonitemPrice = "addonitem_price"
        case active, attributes
        case addonitemRank = "addonitem_rank"
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    let attributeid, attribute, active: String
}

// MARK: - Category
struct Category: Codable {
    let categoryid, active, categoryrank, parentCategoryID: String
    let categoryname, categorytimings, categoryImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case categoryid, active, categoryrank
        case parentCategoryID = "parent_category_id"
        case categoryname, categorytimings
        case categoryImageURL = "category_image_url"
    }
}

// MARK: - Item
struct Item: Codable {
    let itemid, itemallowvariation, itemrank, itemCategoryid: String
    let itemOrdertype: ItemOrdertype
    let itemPackingcharges, itemallowaddon, itemaddonbasedon, itemFavorite: String
    let ignoreTaxes, ignoreDiscounts, inStock: String
    let variation: [ItemVariation]
    let addon: [Addon]
    let itemname, itemAttributeid: String
    let itemdescription: Itemdescription
    let minimumpreparationtime, price, active, itemImageURL: String
    let itemTax: String
    
    enum CodingKeys: String, CodingKey {
        case itemid, itemallowvariation, itemrank
        case itemCategoryid = "item_categoryid"
        case itemOrdertype = "item_ordertype"
        case itemPackingcharges = "item_packingcharges"
        case itemallowaddon, itemaddonbasedon
        case itemFavorite = "item_favorite"
        case ignoreTaxes = "ignore_taxes"
        case ignoreDiscounts = "ignore_discounts"
        case inStock = "in_stock"
        case variation, addon, itemname
        case itemAttributeid = "item_attributeid"
        case itemdescription, minimumpreparationtime, price, active
        case itemImageURL = "item_image_url"
        case itemTax = "item_tax"
    }
}

// MARK: - Addon
struct Addon: Codable {
    let addonGroupID, addonItemSelectionMin, addonItemSelectionMax: String
    
    enum CodingKeys: String, CodingKey {
        case addonGroupID = "addon_group_id"
        case addonItemSelectionMin = "addon_item_selection_min"
        case addonItemSelectionMax = "addon_item_selection_max"
    }
}

enum ItemOrdertype: String, Codable {
    case the123 = "1,2,3"
    case the13 = "1,3"
    case the13509 = "1,3,50,9"
    case the31 = "3,1"
    case the35091 = "3,50,9,1"
}

enum Itemdescription: String, Codable {
    case boneless = "Boneless"
    case empty = ""
    case simpleAlooTikkiInsSoftBurgerBun = "Simple Aloo Tikki ins Soft Burger Bun"
    case tandooriNaan = "Tandoori Naan"
    case vegSpringRolls = "Veg Spring Rolls"
}

// MARK: - ItemVariation
struct ItemVariation: Codable {
    let id, variationid, name: String
    let groupname: Groupname
    let price, active, itemPackingcharges, variationrank: String
    let addon: [Addon]
    let variationallowaddon: Int
    
    enum CodingKeys: String, CodingKey {
        case id, variationid, name, groupname, price, active
        case itemPackingcharges = "item_packingcharges"
        case variationrank, addon, variationallowaddon
    }
}

enum Groupname: String, Codable {
    case mediumSpicy = "Medium Spicy"
    case plainNaan = "Plain Naan"
    case variation = "Variation"
}

// MARK: - Ordertype
struct Ordertype: Codable {
    let ordertypeid: Int
    let ordertype: String
}

// MARK: - Restaurant
struct Restaurant: Codable {
    let restaurantid, active: String
    let details: Details
}

// MARK: - Details
struct Details: Codable {
    let menusharingcode, country: String
    let images: [JSONAny]
    let restaurantname, address, contact, latitude: String
    let longitude, landmark, city, state: String
    let minimumorderamount, minimumdeliverytime, deliverycharge, deliveryhoursfrom1: String
    let deliveryhoursto1, deliveryhoursfrom2, deliveryhoursto2: String
    let calculatetaxonpacking, calculatetaxondelivery: Int
    let packagingApplicableOn, packagingCharge, packagingChargeType: String
    
    enum CodingKeys: String, CodingKey {
        case menusharingcode, country, images, restaurantname, address, contact, latitude, longitude, landmark, city, state, minimumorderamount, minimumdeliverytime, deliverycharge, deliveryhoursfrom1, deliveryhoursto1, deliveryhoursfrom2, deliveryhoursto2, calculatetaxonpacking, calculatetaxondelivery
        case packagingApplicableOn = "packaging_applicable_on"
        case packagingCharge = "packaging_charge"
        case packagingChargeType = "packaging_charge_type"
    }
}

// MARK: - WelcomeVariation
struct WelcomeVariation: Codable {
    let variationid, name, groupname, status: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}


class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var fetchingMenuLabel: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var cartTableView: UITableView!
    
    @IBOutlet weak var addToCartView: UIView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var reduceQuantityBtn: CustomButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var increaseQuantityBtn: CustomButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dismissBtn: CustomButton!
    @IBOutlet weak var addToCartBtn: CustomButton!
    @IBOutlet weak var cartBtnsView: UIStackView!
    @IBOutlet weak var backCartBtn: CustomButton!
    @IBOutlet weak var proceedCartBtn: CustomButton!
    
    @IBOutlet weak var confirmOrderView: UIView!
    @IBOutlet weak var pickupBtn: CustomButton!
    @IBOutlet weak var deliveryButton: CustomButton!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var cancelBtn: CustomButton!
    @IBOutlet weak var orderBtn: CustomButton!
    
    var restID = ""
    
    var ids:[String] = []
    var items: [String] = []
    var variations: [String] = []
    var prices: [String] = []
    
    var orderIDs: [String] = []
    var orderItems: [String] = []
    var orderQuantity: [String] = []
    var orderPrice: [String] = []
    
    var currentQuantity: Int = 1
    var currentPrice: Int = 0
    var currentIndex: Int = 0
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "itemCell"
    let cartItemIdentifier = "cartItem"
    let cartTotalIdentifier = "cartTotal"
    
    var orderType = "pickup"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.cartTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        addToCartView.layer.cornerRadius = 16.0
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.rowHeight = 98.0
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.rowHeight = 98.0
        
        reduceQuantityBtn.setBackgroundColor(color: UIColor.init(red: 52/255, green: 55/255, blue: 60/255, alpha: 1.0), forState: .highlighted)
        reduceQuantityBtn.setCornerRadius(radius: 16.0)
        
        increaseQuantityBtn.setBackgroundColor(color: UIColor.init(red: 52/255, green: 55/255, blue: 60/255, alpha: 1.0), forState: .highlighted)
        increaseQuantityBtn.setCornerRadius(radius: 16.0)
        
        dismissBtn.setBackgroundColor(color: UIColor.init(red: 52/255, green: 55/255, blue: 60/255, alpha: 1.0), forState: .normal)
        dismissBtn.setBackgroundColor(color: UIColor.init(red: 127/255, green: 29/255, blue: 29/255, alpha: 1.0), forState: .highlighted)
        dismissBtn.setCornerRadius(radius: 16.0)
        
        addToCartBtn.setBackgroundColor(color: UIColor.init(red: 22/255, green: 163/255, blue: 74/255, alpha: 1.0), forState: .normal)
        addToCartBtn.setBackgroundColor(color: UIColor.init(red: 22/255, green: 128/255, blue: 61/255, alpha: 1.0), forState: .highlighted)
        addToCartBtn.setCornerRadius(radius: 16.0)
        
        backCartBtn.setBackgroundColor(color: UIColor.init(red: 52/255, green: 55/255, blue: 60/255, alpha: 1.0), forState: .normal)
        backCartBtn.setBackgroundColor(color: UIColor.init(red: 127/255, green: 29/255, blue: 29/255, alpha: 1.0), forState: .highlighted)
        backCartBtn.setCornerRadius(radius: 16.0)
        
        proceedCartBtn.setBackgroundColor(color: UIColor.init(red: 22/255, green: 163/255, blue: 74/255, alpha: 1.0), forState: .normal)
        proceedCartBtn.setBackgroundColor(color: UIColor.init(red: 22/255, green: 128/255, blue: 61/255, alpha: 1.0), forState: .highlighted)
        proceedCartBtn.setCornerRadius(radius: 16.0)
        
        pickupBtn.setBackgroundColor(color: UIColor.init(red: 217/255, green: 119/255, blue: 6/255, alpha: 1.0), forState: .highlighted)
        pickupBtn.setBackgroundColor(color: UIColor.init(red: 245/255, green: 158/255, blue: 11/255, alpha: 1.0), forState: .selected)
        pickupBtn.setCornerRadius(radius: 16.0)
        pickupBtn.isSelected = true
        
        deliveryButton.setBackgroundColor(color: UIColor.init(red: 217/255, green: 119/255, blue: 6/255, alpha: 1.0), forState: .highlighted)
        deliveryButton.setBackgroundColor(color: UIColor.init(red: 245/255, green: 158/255, blue: 11/255, alpha: 1.0), forState: .selected)
        deliveryButton.setCornerRadius(radius: 16.0)
        
        cancelBtn.setBackgroundColor(color: UIColor.init(red: 52/255, green: 55/255, blue: 60/255, alpha: 1.0), forState: .normal)
        cancelBtn.setBackgroundColor(color: UIColor.init(red: 127/255, green: 29/255, blue: 29/255, alpha: 1.0), forState: .highlighted)
        cancelBtn.setCornerRadius(radius: 16.0)
        
        orderBtn.setBackgroundColor(color: UIColor.init(red: 22/255, green: 163/255, blue: 74/255, alpha: 1.0), forState: .normal)
        orderBtn.setBackgroundColor(color: UIColor.init(red: 22/255, green: 128/255, blue: 61/255, alpha: 1.0), forState: .highlighted)
        orderBtn.setCornerRadius(radius: 16.0)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        confirmOrderView.addGestureRecognizer(tap)
        
        let session = URLSession.shared
        let url = URL(string: "https://pponlineordercb.petpooja.com/mapped_restaurant_menus")!
        
        let parameters = ["restID": restID, "data_type": "json"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("3k8pysardf4xj0597gcowuh6emqz2ti1", forHTTPHeaderField: "app-key")
        request.setValue("9ef4ebc3b9bcfc00ab8fbcca10413fea7463c242", forHTTPHeaderField: "app-secret")
        request.setValue("50417828184475e223ca0293566564344604c2f2", forHTTPHeaderField: "access-token")
        
        //create data Task using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                    let jsonData = JSONString.data(using: .utf8)!
                    let all = try! JSONDecoder().decode(Welcome.self, from: jsonData)
                    for item in all.items {
                        if item.itemallowvariation == "1" {
                            for variation in item.variation {
                                self.ids.append(variation.id)
                                self.items.append(item.itemname)
                                self.variations.append(variation.name)
                                self.prices.append(variation.price)
                            }
                        }
                        else {
                            self.ids.append(item.itemid)
                            self.items.append(item.itemname)
                            self.variations.append("")
                            self.prices.append(item.price)
                        }
                    }
                    DispatchQueue.main.async {
                        self.menuTableView.reloadData()
                        self.fetchingMenuLabel.isHidden = true
                    }
                }
            }
        })
        task.resume()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cartBtnPressed(_ sender: Any) {
        cartTableView.isHidden = false
        cartBtnsView.isHidden = false
    }
    
    @IBAction func reduceBtnPressed(_ sender: Any) {
        if currentQuantity > 1 {
            currentQuantity -= 1
            quantityLabel.text = String(currentQuantity)
            currentPrice = currentQuantity * Int(prices[currentIndex])!
            priceLabel.text = "Rs. " + String(currentPrice)
        }
    }
    
    @IBAction func increaseBtnPressed(_ sender: Any) {
        currentQuantity += 1
        quantityLabel.text = String(currentQuantity)
        currentPrice = currentQuantity * Int(prices[currentIndex])!
        priceLabel.text = "Rs. " + String(currentPrice)
    }
    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        addToCartView.isHidden = true
    }
    
    @IBAction func addToCartBtnPressed(_ sender: Any) {
        if orderIDs.contains(ids[currentIndex]) {
            let newQuantity = Int(orderQuantity[orderIDs.firstIndex(of: ids[currentIndex])!])! + Int(quantityLabel.text!)!
            orderQuantity[orderIDs.firstIndex(of: ids[currentIndex])!] = String(newQuantity)
            let newPrice = Int(orderPrice[orderIDs.firstIndex(of: ids[currentIndex])!])! + currentPrice
            orderPrice[orderIDs.firstIndex(of: ids[currentIndex])!] = String(newPrice)
        } else {
            orderIDs.append(ids[currentIndex])
            orderItems.append(itemNameLabel.text!)
            orderQuantity.append(quantityLabel.text!)
            orderPrice.append(String(currentPrice))
        }
        cartBtn.isHidden = false
        addToCartView.isHidden = true
        
        cartTableView.reloadData()
    }
    
    @IBAction func backCartBtnPressed(_ sender: Any) {
        cartTableView.isHidden = true
        cartBtnsView.isHidden = true
    }
    
    @IBAction func proceedCartBtnPressed(_ sender: Any) {
        confirmOrderView.isHidden = false
    }
    
    @IBAction func pickupBtnPressed(_ sender: Any) {
        pickupBtn.isSelected = true
        deliveryButton.isSelected = false
        orderType = "pickup"
        addressText.isHidden = true
    }
    
    @IBAction func deliveryBtnPressed(_ sender: Any) {
        pickupBtn.isSelected = false
        deliveryButton.isSelected = true
        orderType = "delivery"
        addressText.isHidden = false
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        confirmOrderView.isHidden = true
    }
    
    @IBAction func orderBtnPressed(_ sender: Any) {
        guard let nameEntered = nameText.text, !nameEntered.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            showToast(message: "Name cannot be empty")
            return
        }
        
        guard let phoneEntered = phoneText.text, !phoneEntered.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            showToast(message: "Phone cannot be empty")
            return
        }
        
        if phoneEntered.count != 10 {
            showToast(message: "Phone must be 10 digits long")
            return
        }
        
        let session = URLSession.shared
        let url = URL(string: "https://www.figos.in/ordercheck.php")!
        
        let source: [String] = [restID, nameEntered, phoneEntered, addressText.text != "" ? addressText.text!: ""]
        
        var parameters: [[String]] = [source]
        
        for i in 0..<orderIDs.count {
            var order: [String] = []
            order.append(orderItems[i])
            order.append(orderQuantity[i])
            order.append(orderPrice[i])
            
            parameters.append(order)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //create data Task using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                    if JSONString == "Success" {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Order Placed", message: "Your order has been placed successfully. You may receive a verification call from our side soon.", preferredStyle: UIAlertController.Style.alert)
                            
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                                action in
                                self.dismiss(animated: true, completion: nil)
                            }))
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Error", message: "Some error occured while placing order. Kindly place order again", preferredStyle: UIAlertController.Style.alert)
                            
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == menuTableView {
            return items.count
        }
        else {
            return orderIDs.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == menuTableView {
            let cell:MenuCell = menuTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MenuCell
            cell.itemCount.text = String(indexPath.row + 1)
            cell.itemName.text = items[indexPath.row]
            cell.price.text = "Rs. "+prices[indexPath.row]
            if (variations[indexPath.row] == ""){
                cell.variation.isHidden = true
            } else {
                cell.variation.text = variations[indexPath.row]
                cell.variation.isHidden = false
            }
            return cell
        }
        else {
            let itemCell:CartTableViewCell = cartTableView.dequeueReusableCell(withIdentifier: cartItemIdentifier, for: indexPath) as! CartTableViewCell
            let totalCell:TotalTableViewCell = cartTableView.dequeueReusableCell(withIdentifier: cartTotalIdentifier, for: indexPath) as! TotalTableViewCell
            
            if indexPath.row < orderIDs.count {
                itemCell.itemCount.text = String(indexPath.row + 1)
                itemCell.itemName.text = orderItems[indexPath.row]
                itemCell.quantity.text = "Quantity: \(orderQuantity[indexPath.row])"
                itemCell.price.text = "Price: Rs. \(orderPrice[indexPath.row])"
                itemCell.selectionStyle = .none
                return itemCell
            } else {
                var amount = 0
                for amt in orderPrice {
                    amount += Int(amt)!
                }
                totalCell.totalAmount.text = "Total: Rs. \(amount)"
                totalCell.selectionStyle = .none
                return totalCell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == menuTableView {
            if (variations[indexPath.row] == ""){
                itemNameLabel.text = items[indexPath.row]
            } else {
                itemNameLabel.text = items[indexPath.row] + " - " + variations[indexPath.row]
            }
            currentQuantity = 1
            currentIndex = indexPath.row
            quantityLabel.text = String(currentQuantity)
            currentPrice = Int(prices[indexPath.row])!
            priceLabel.text = "Rs. " + String(currentPrice)
            addToCartView.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == cartTableView {
            if editingStyle == .delete {
                if indexPath.row == orderIDs.count {
                    return
                }
                orderIDs.remove(at: indexPath.row)
                orderPrice.remove(at: indexPath.row)
                orderItems.remove(at: indexPath.row)
                orderQuantity.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                cartTableView.reloadData()
                if orderIDs.count == 0 {
                    cartBtn.isHidden = true
                    cartTableView.isHidden = true
                    cartBtnsView.isHidden = true
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView == menuTableView {
            return UITableViewCell.EditingStyle.none
        } else {
            return UITableViewCell.EditingStyle.delete
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
