//
//  SecondViewController.swift
//  AmusementParkApp
//
//  Created by LOGIN on 2019-02-19.
//  Copyright © 2019 Chirag Jadhwani. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}


class SecondViewController: UIViewController {
    override func viewDidLoad() {
        print("Statement executed")
        fillDataFor()
        AmusementButton.isEnabled = false
        AmusementButton.isHidden = true
        KitchenButton.isEnabled = false
        KitchenButton.isHidden = true
        RideControlButton.isEnabled = false
        RideControlButton.isHidden = true
        MaintenanceButton.isEnabled = false
        MaintenanceButton.isHidden = true
        OfficeButton.isEnabled = false
        OfficeButton.isHidden = true
        
        
    }
    var guestActive = false
    var employeeActive = false
    var vendorActive = false
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var TypeLabel: UILabel!
    @IBOutlet weak var Character1Label: UILabel!
    @IBOutlet weak var Character2Label: UILabel!
    @IBOutlet weak var Character3Label: UILabel!
    @IBOutlet weak var EntrantImage: UIImageView!
    @IBOutlet weak var TestResults: UILabel!
    @IBOutlet weak var SecondaryLevel: UIStackView!
    
    @IBOutlet weak var AmusementButton: UIButton!
    @IBOutlet weak var KitchenButton: UIButton!
    @IBOutlet weak var RideControlButton: UIButton!
    @IBOutlet weak var MaintenanceButton: UIButton!
    @IBOutlet weak var OfficeButton: UIButton!

    
    
    func fillDataFor() {
        if ThePassForGuest != nil{
            NameLabel.text = "Guest Pass"
            TypeLabel.text = GuestEntrant?.guestType.rawValue ?? "Error in pass generation"
            Character1Label.text = "Unlimited Rides"
            Character2Label.text = "Food discount: \(GuestEntrant?.availDiscount[.food] ?? 0.0)"
            Character3Label.text = "Merch discount: \(GuestEntrant?.availDiscount[.merchandise] ?? 0.0)"
            guestActive = true
        } else if ThePassForEmployee != nil{
            NameLabel.text = "\(ThePassForEmployee?.Entrant.firstName ?? "Employee")  \(ThePassForEmployee?.Entrant.lastName ?? "Pass")"
            TypeLabel.text = ThePassForEmployee?.Entrant.entrantType.rawValue ?? "Error in pass generation"
            Character1Label.text = (EmployeeEntrant is Contractor) ? "No access to rides" : "Access to rides"
            Character2Label.text = "Food discount: \(ThePassForEmployee?.Entrant.availDiscount[.food] ?? 0.0)"
            Character3Label.text = "Merch discount: \(ThePassForEmployee?.Entrant.availDiscount[.merchandise] ?? 0.0)"
            employeeActive = true
        } else if ThePassForVendor != nil {
            NameLabel.text = "\(ThePassForVendor?.Entrant.firstName ?? "Vendor")  \(ThePassForVendor?.Entrant.lastName ?? "Pass")"
            TypeLabel.text = ThePassForVendor?.Entrant.entrantType.rawValue ?? "Error in pass generation"
            Character1Label.text = "No access to rides"
            Character2Label.text = "Food discount: \(ThePassForVendor?.Entrant.availDiscount[.food] ?? 0.0)"
            Character3Label.text = "Merch discount: \(ThePassForVendor?.Entrant.availDiscount[.merchandise] ?? 0.0)"
            vendorActive = true
        }
    }
    
    @IBAction func areaAccess(_ sender: Any) {
        AmusementButton.isEnabled = true
        AmusementButton.isHidden = false
        KitchenButton.isEnabled = true
        KitchenButton.isHidden = false
        RideControlButton.isEnabled = true
        RideControlButton.isHidden = false
        MaintenanceButton.isEnabled = true
        MaintenanceButton.isHidden = false
        OfficeButton.isEnabled = true
        OfficeButton.isHidden = false
        TestResults.text = "Test Results"
        TestResults.backgroundColor = UIColor.white
    }
    
    @IBAction func rideAccess(_ sender: Any) {
        var result = false
        if guestActive {
            result = ThePassForGuest?.swipeAtRide() ?? false
        } else if employeeActive {
            result = ThePassForEmployee?.swipeAtRide() ?? false
        } else if vendorActive {
            result = ThePassForVendor?.swipeAtRide() ?? false
        } else {
            result = false
        }
        
        if result {
            TestResults.text = "Access Granted"
            TestResults.backgroundColor = UIColor.green
        } else {
            TestResults.text = "Access Denied"
            TestResults.backgroundColor = UIColor.red
        }
        
        print(result)
        AmusementButton.isEnabled = false
        AmusementButton.isHidden = true
        KitchenButton.isEnabled = false
        KitchenButton.isHidden = true
        RideControlButton.isEnabled = false
        RideControlButton.isHidden = true
        MaintenanceButton.isEnabled = false
        MaintenanceButton.isHidden = true
        OfficeButton.isEnabled = false
        OfficeButton.isHidden = true
    }
    
    @IBAction func discountAccess(_ sender: Any) {
        var foodResult = 0.0
        var merchResult = 0.0
        if guestActive {
            foodResult = ThePassForGuest?.swipeToAvailDiscounts(for: .food) ?? 0.0
            merchResult = ThePassForGuest?.swipeToAvailDiscounts(for: .merchandise) ?? 0.0
        } else if employeeActive {
            foodResult = ThePassForEmployee?.swipeToAvailDiscounts(for: .food) ?? 0.0
            merchResult = ThePassForEmployee?.swipeToAvailDiscounts(for: .merchandise) ?? 0.0
        } else if vendorActive {
            foodResult = ThePassForVendor?.swipeToAvailDiscounts(for: .food) ?? 0.0
            merchResult = ThePassForVendor?.swipeToAvailDiscounts(for: .merchandise) ?? 0.0
        }
        
        if foodResult == 0 && merchResult == 0{
            TestResults.text = "You are not eligible for a discount"
            TestResults.backgroundColor = UIColor.red
        } else {
            TestResults.text = "You are eligible for a \(foodResult)% food discount and a \(merchResult)% merchandise discount"
            TestResults.backgroundColor = UIColor.green
        }
        AmusementButton.isEnabled = false
        AmusementButton.isHidden = true
        KitchenButton.isEnabled = false
        KitchenButton.isHidden = true
        RideControlButton.isEnabled = false
        RideControlButton.isHidden = true
        MaintenanceButton.isEnabled = false
        MaintenanceButton.isHidden = true
        OfficeButton.isEnabled = false
        OfficeButton.isHidden = true
    }
    
    @IBAction func AmusementCheck(_ sender: Any) {
        if guestActive {
            do {
                let result = try ThePassForGuest?.swipeAt(area: .Amusement)
                if result != nil && result == true {
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        } else if employeeActive {
            do {
                let result = try ThePassForEmployee?.swipeAt(area: .Amusement)
                if result != nil && result == true {
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        } else if vendorActive {
            do {
                let result = try ThePassForVendor?.swipeAt(area: .Amusement)
                if result != nil && result == true {
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        }
    }
    
    @IBAction func KitchenButton(_ sender: Any) {
        if guestActive {
            do {
                let result = try ThePassForGuest?.swipeAt(area: .Kitchen)
                if result != nil && result == true {
                    
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        } else if employeeActive {
            do {
                let result = try ThePassForEmployee?.swipeAt(area: .Kitchen)
                if result != nil && result == true {
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        } else if vendorActive {
            do {
                let result = try ThePassForVendor?.swipeAt(area: .Kitchen)
                if result != nil && result == true {
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        }
    }
    @IBAction func RideControlButton(_ sender: Any) {
        if guestActive {
            do {
                let result = try ThePassForGuest?.swipeAt(area: .RideControl)
                if result != nil && result == true {
                    
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        } else if employeeActive {
            do {
                let result = try ThePassForEmployee?.swipeAt(area: .RideControl)
                if result != nil && result == true {
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        } else if vendorActive {
            do {
                let result = try ThePassForVendor?.swipeAt(area: .RideControl)
                if result != nil && result == true {
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        }
    }
    @IBAction func MaintenanceButton(_ sender: Any) {
        if guestActive {
            do {
                let result = try ThePassForGuest?.swipeAt(area: .Maintenance)
                if result != nil && result == true {
                    
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        } else if employeeActive {
            do {
                let result = try ThePassForEmployee?.swipeAt(area: .Maintenance)
                if result != nil && result == true {
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        } else if vendorActive {
            do {
                let result = try ThePassForVendor?.swipeAt(area: .Maintenance)
                if result != nil && result == true {
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        }
    }
    
    @IBAction func OfficeButton(_ sender: Any) {
        if guestActive {
            do {
                let result = try ThePassForGuest?.swipeAt(area: .Office)
                if result != nil && result == true {
                    
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        } else if employeeActive {
            do {
                let result = try ThePassForEmployee?.swipeAt(area: .Office)
                if result != nil && result == true {
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        } else if vendorActive {
            do {
                let result = try ThePassForVendor?.swipeAt(area: .Office)
                if result != nil && result == true {
                    TestResults.text = "Access granted"
                    TestResults.backgroundColor = UIColor.green
                }
            } catch swipeErrors.accessDenied {
                TestResults.text = "Access denied"
                TestResults.backgroundColor = UIColor.red
                // handle errors
            } catch {
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
    @IBAction func CreateNewPass(_ sender: Any) {
        GuestEntrant = nil
        ThePassForGuest = nil
        EmployeeEntrant = nil
        ThePassForEmployee = nil
        VendorEntrant = nil
        ThePassForVendor = nil
        guestActive = false
        employeeActive = false
        vendorActive = false
        AmusementButton.isEnabled = false
        AmusementButton.isHidden = true
        KitchenButton.isEnabled = false
        KitchenButton.isHidden = true
        RideControlButton.isEnabled = false
        RideControlButton.isHidden = true
        MaintenanceButton.isEnabled = false
        MaintenanceButton.isHidden = true
        OfficeButton.isEnabled = false
        OfficeButton.isHidden = true
        TestResults.text = "Test Results"
        TestResults.backgroundColor = UIColor.white
        performSegue(withIdentifier: "NewPass", sender: nil)
    }
    
}
