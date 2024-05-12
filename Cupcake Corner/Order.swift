//
//  Order.swift
//  Cupcake Corner
//
//  Created by Brian Vo on 5/10/24.
//

import Foundation

@Observable
class Order: Codable{
    
    enum CodingKeys: String, CodingKey{
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
        
    }
    
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    
//    var name = ""
//    var city = ""
//    var streetAddress = ""
//    var zip = ""
    
    var name = UserDefaults.standard.string(forKey: "name") ?? "" {
          didSet {
              UserDefaults.standard.setValue(name, forKey: "name")
          }
      }

      var streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? "" {
          didSet {
              UserDefaults.standard.setValue(streetAddress, forKey: "streetAddress")
          }
      }

      var city = UserDefaults.standard.string(forKey: "city") ?? "" {
          didSet {
              UserDefaults.standard.setValue(city, forKey: "city")
          }
      }

      var zip = UserDefaults.standard.string(forKey: "zip") ?? "" {
          didSet {
              UserDefaults.standard.setValue(zip, forKey: "zip")
          }
      }
    
    
    var hasValidAddress: Bool{
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
        
        
    }
    
    
    
    
    
    var cost : Decimal {
//        2$ per cake
        var cost = Decimal(quantity) * 2
//        more features cost more
        cost += Decimal(type) / 2
//        1 dollar for cake for extra frosting
        if(extraFrosting){
            cost += Decimal(quantity)
        }
//        50 cents for cake with sprinkles
        if(addSprinkles){
            cost += Decimal(quantity) / 2
        }
        
        return cost
        
        
        
    }
    
    
}
