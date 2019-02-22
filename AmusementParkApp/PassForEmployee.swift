//
//  PassForEmployee.swift
//  AmusementParkApp
//
//  Created by LOGIN on 2019-02-22.
//  Copyright © 2019 Chirag Jadhwani. All rights reserved.
//

import Foundation


enum ErrorsForEmployees: String, Error {
    case AllDetailsMissing = "All properties are empty"
    case MissingFirstName = "The first name of the entrant is missing"
    case MissingLastName = "The last name of the entrant is missing"
    case MissingAddress = "The street address of the entrant is missing"
    case MissingCity = "The city of the entrant is missing"
    case MissingState = "The state of the entrant is missing"
    case MissingZip = "The Zip code of the entrant is missing"
    case MissingVendorCompany = "The vendor's company is missing"
    case MissingDateOfBirth = "The date of birth is missing"
    case MissingDateOfVisit = "The date of visit is missing"
    case MissingProject = "The contractor's project is missing"
    case MissingSSN = "The SSN is missing"
    case MissingManagerType = "The type of manager is missing"
    case InvalidZip = "The zip code is in an incorrect format"
}


class PassForEmployee {
    var Entrant: Employee
    
    init(Entrant: Employee){
        self.Entrant = Entrant
    }
    
    func generatePass() throws -> Bool {
        guard let zip = self.Entrant.zip else {throw ErrorsForEmployees.MissingZip}
        if self.Entrant is Contractor {
            
            if self.Entrant.firstName == "" && self.Entrant.lastName == "" && self.Entrant.zip == "" && self.Entrant.state == "" && self.Entrant.streetAddress == "" && self.Entrant.city == "" && self.Entrant.SSN == "" && self.Entrant.Birthday == "" && self.Entrant.project == "" {
                self.Entrant.passGenerated = false
                throw ErrorsForEmployees.AllDetailsMissing
            } else if self.Entrant.firstName == "" || self.Entrant.firstName == nil {
                throw ErrorsForEmployees.MissingFirstName
            } else if self.Entrant.lastName == "" || self.Entrant.lastName == nil {
                throw ErrorsForEmployees.MissingLastName
            }  else if self.Entrant.streetAddress == "" || self.Entrant.streetAddress == nil {
                throw ErrorsForEmployees.MissingAddress
            }  else if self.Entrant.city == "" || self.Entrant.city == nil {
                throw ErrorsForEmployees.MissingCity
            }  else if self.Entrant.state == "" || self.Entrant.state == nil {
                throw ErrorsForEmployees.MissingState
            }  else if self.Entrant.zip == "" || self.Entrant.zip == nil {
                throw ErrorsForEmployees.MissingZip
            } else if self.Entrant.Birthday == "" || self.Entrant.Birthday == nil {
                throw ErrorsForEmployees.MissingDateOfBirth
            } else if self.Entrant.SSN == "" || self.Entrant.SSN == nil {
                throw ErrorsForEmployees.MissingSSN
            } else if self.Entrant.project == "" || self.Entrant.project == nil {
                throw ErrorsForEmployees.MissingProject
            } else if zip.isNumber == false && zip.count != 5 {
                throw ErrorsForEmployees.InvalidZip
            } else {
                self.Entrant.passGenerated = true
                return true
            }
            
        } else if Entrant is Manager {
            guard let theManager = self.Entrant as? Manager else {throw ErrorsForEmployees.AllDetailsMissing}
            if self.Entrant.firstName == "" && self.Entrant.lastName == "" && self.Entrant.zip == "" && self.Entrant.state == "" && self.Entrant.streetAddress == "" && self.Entrant.city == "" && self.Entrant.SSN == "" && self.Entrant.Birthday == "" && theManager.ManagerType == "" {
                self.Entrant.passGenerated = false
                throw ErrorsForEmployees.AllDetailsMissing
            } else if self.Entrant.firstName == "" || self.Entrant.firstName == nil {
                throw ErrorsForEmployees.MissingFirstName
            } else if self.Entrant.lastName == "" || self.Entrant.lastName == nil {
                throw ErrorsForEmployees.MissingLastName
            }  else if self.Entrant.streetAddress == "" || self.Entrant.streetAddress == nil {
                throw ErrorsForEmployees.MissingAddress
            }  else if self.Entrant.city == "" || self.Entrant.city == nil {
                throw ErrorsForEmployees.MissingCity
            }  else if self.Entrant.state == "" || self.Entrant.state == nil {
                throw ErrorsForEmployees.MissingState
            }  else if self.Entrant.zip == "" || self.Entrant.zip == nil {
                throw ErrorsForEmployees.MissingZip
            } else if self.Entrant.Birthday == "" || self.Entrant.Birthday == nil {
                throw ErrorsForEmployees.MissingDateOfBirth
            } else if self.Entrant.SSN == "" || self.Entrant.SSN == nil {
                throw ErrorsForEmployees.MissingSSN
            } else if theManager.ManagerType == "" || theManager.ManagerType == nil{
                throw ErrorsForEmployees.MissingManagerType
            } else if zip.isNumber == false && zip.count != 5 {
                throw ErrorsForEmployees.InvalidZip
            } else {
                self.Entrant.passGenerated = true
                return true
            }
            
        } else {
            if self.Entrant.firstName == "" && self.Entrant.lastName == "" && self.Entrant.zip == "" && self.Entrant.state == "" && self.Entrant.streetAddress == "" && self.Entrant.city == "" && self.Entrant.SSN == "" && self.Entrant.Birthday == "" {
                self.Entrant.passGenerated = false
                throw ErrorsForEmployees.AllDetailsMissing
            } else if self.Entrant.firstName == "" || self.Entrant.firstName == nil {
                throw ErrorsForEmployees.MissingFirstName
            } else if self.Entrant.lastName == "" || self.Entrant.lastName == nil {
                throw ErrorsForEmployees.MissingLastName
            }  else if self.Entrant.streetAddress == "" || self.Entrant.streetAddress == nil {
                throw ErrorsForEmployees.MissingAddress
            }  else if self.Entrant.city == "" || self.Entrant.city == nil {
                throw ErrorsForEmployees.MissingCity
            }  else if self.Entrant.state == "" || self.Entrant.state == nil {
                throw ErrorsForEmployees.MissingState
            }  else if self.Entrant.zip == "" || self.Entrant.zip == nil {
                throw ErrorsForEmployees.MissingZip
            } else if self.Entrant.Birthday == "" || self.Entrant.Birthday == nil {
                throw ErrorsForEmployees.MissingDateOfBirth
            } else if self.Entrant.SSN == "" || self.Entrant.SSN == nil {
                throw ErrorsForEmployees.MissingSSN
            } else if zip.isNumber == false && zip.count != 5 {
                throw ErrorsForEmployees.InvalidZip
            } else {
                self.Entrant.passGenerated = true
                return true
            }
        }
    }

    
    func swipeToSkipRideLines() throws -> Bool {
        
        if self.Entrant.passGenerated {
            if self.Entrant.skipRideAccess {
                return true
            } else {
                throw swipeErrors.accessDenied
            }
        } else {
            throw swipeErrors.passNotGenerated
        }
    }
    
    func swipeToAvailDiscounts(for item: discountItems) -> Double {
        var discountValue: Double = 0.0
        if self.Entrant.passGenerated {
            
            let dictionaryOfDiscountValues = self.Entrant.availDiscount
            for (key, value) in dictionaryOfDiscountValues {
                if key == item {
                    discountValue = value
                }
            }
            
        }
        return discountValue
    }
    func swipeAtRide() -> Bool {
        if self.Entrant is Contractor {
            return false
        } else {
            return true
        }
    }
    func swipeAt(area: Area) throws -> Bool {
        var accessStatus = false
        
        if self.Entrant is Manager {
            // Since manager has access to all areas in the site
            accessStatus = true
        } else if self.Entrant is RideServices || self.Entrant is FoodServices || self.Entrant is MaintenanceServices {
            /*
            for allowedArea in self.Entrant.accessAreas {
                if allowedArea == area.rawValue {
                    accessStatus = true
                } else {
                    accessStatus = false
                }
            }
            */
            if self.Entrant is RideServices {
                
                if area == .Amusement {
                    accessStatus = true
                } else if area == .Kitchen {
                    accessStatus = false
                } else if area == .Maintenance {
                    accessStatus = false
                } else if area == .Office {
                    accessStatus = false
                } else if area == .RideControl {
                    accessStatus = true
                }
                
            } else if self.Entrant is FoodServices {
                
                if area == .Amusement {
                    accessStatus = true
                } else if area == .Kitchen {
                    accessStatus = true
                } else if area == .Maintenance {
                    accessStatus = false
                } else if area == .Office {
                    accessStatus = false
                } else if area == .RideControl {
                    accessStatus = false
                }
                
            } else if self.Entrant is MaintenanceServices {
                
                if area == .Amusement {
                    accessStatus = true
                } else if area == .Kitchen {
                    accessStatus = true
                } else if area == .Maintenance {
                    accessStatus = true
                } else if area == .Office {
                    accessStatus = false
                } else if area == .RideControl {
                    accessStatus = true
                }
                
            }
            
        } else if self.Entrant is Contractor {
            
            
            if self.Entrant.project == ProjectClassifications.P1001.rawValue {
                
                if area == .Amusement {
                    accessStatus = true
                } else if area == .Kitchen {
                    accessStatus = false
                } else if area == .Maintenance {
                    accessStatus = false
                } else if area == .Office {
                    accessStatus = false
                } else if area == .RideControl {
                    accessStatus = true
                }
                
            } else if self.Entrant.project == ProjectClassifications.P1002.rawValue {
                
                if area == .Amusement {
                    accessStatus = true
                } else if area == .Kitchen {
                    accessStatus = false
                } else if area == .Maintenance {
                    accessStatus = true
                } else if area == .Office {
                    accessStatus = false
                } else if area == .RideControl {
                    accessStatus = true
                }
                
            }else if self.Entrant.project == ProjectClassifications.P1003.rawValue {
                
                if area == .Amusement {
                    accessStatus = true
                } else if area == .Kitchen {
                    accessStatus = true
                } else if area == .Maintenance {
                    accessStatus = true
                } else if area == .Office {
                    accessStatus = true
                } else if area == .RideControl {
                    accessStatus = true
                }
                
            }else if self.Entrant.project == ProjectClassifications.P2001.rawValue {
                
                if area == .Amusement {
                    accessStatus = false
                } else if area == .Kitchen {
                    accessStatus = false
                } else if area == .Maintenance {
                    accessStatus = false
                } else if area == .Office {
                    accessStatus = true
                } else if area == .RideControl {
                    accessStatus = false
                }
                
            } else if self.Entrant.project == ProjectClassifications.P2002.rawValue {
                
                if area == .Amusement {
                    accessStatus = false
                } else if area == .Kitchen {
                    accessStatus = true
                } else if area == .Maintenance {
                    accessStatus = true
                } else if area == .Office {
                    accessStatus = false
                } else if area == .RideControl {
                    accessStatus = false
                }
            }
        }
        if accessStatus {
         return accessStatus
        } else {
            throw swipeErrors.accessDenied
        }
    }
}
