//
//  PassForGuest.swift
//  AmusementParkApp
//
//  Created by LOGIN on 2019-02-22.
//  Copyright © 2019 Chirag Jadhwani. All rights reserved.
//
/// Errors specific to guest pass
enum ErrorsForGuest: String, Error {
    case ThisEntrantIsNotAChild = "The Entrant is not a child"
    case AgeIsMissing = "The age is missing"
    case passNotGenerated = "Pass is not valid"
    case zipIsMissing = "Zip code is missing"
    case invalidZip = "Zip code is invalid"
}

import Foundation
class PassForGuest {
    var Entrant: Guest
    
    init(Entrant: Guest) {
        self.Entrant = Entrant
    }
    
    // generatePass() function is called to validate the pass. This function is necessary since it validates the properties in the Entrant object. By validating if a property of Entrant object exsist or not.. accordingly errors can be thrown.. Errors which show property is missing. If all the required property exist.. then a stored property of Entrant project "passGenerated" is set to true. passGenerated stored property is used as a flag... for all the swipe operations.. if passGenerated is true then only the operation will occur.. or else an error is thrown -> swipeErrors.passNotGenerated.
    func generatePass() throws -> Bool {
        // A pass is always generated if the Entrant is of type Guest or VIP since there are no parameters. However, if it is a child.. it is checked if the DOB is entered. Then the age is calculated and it is determined if the child should be given access according to their age.
        if Entrant is Child {
            guard let childGuest = Entrant as? Child else { throw ErrorsForGuest.ThisEntrantIsNotAChild }
            
            if childGuest.Age < 5 && childGuest.Age >= 0 && childGuest.Birthday != "" {
                self.Entrant.passGenerated = true
                return true
            } else if childGuest.Age == -1 {
                throw ErrorsForGuest.AgeIsMissing
            } else {
                throw ErrorsForGuest.ThisEntrantIsNotAChild
            }
        } else if Entrant is seasonPassGuest {
            guard let zip = self.Entrant.zip else {throw ErrorsForGuest.zipIsMissing}
            if self.Entrant.firstName == "" && self.Entrant.lastName == "" && self.Entrant.zip == "" && self.Entrant.state == "" && self.Entrant.streetAddress == "" && self.Entrant.city == "" && self.Entrant.Birthday == "" {
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
                throw ErrorsForGuest.AgeIsMissing
            } else if zip.isNumber == false && zip.count != 5 {
                throw ErrorsForGuest.invalidZip
            } else {
                self.Entrant.passGenerated = true
                return true
            }
        } else if Entrant is seniorGuest {
            
            guard let SeniorGuest = self.Entrant as? seniorGuest else {throw ErrorsForGuest.passNotGenerated}
            if self.Entrant.firstName == "" && self.Entrant.lastName == "" && SeniorGuest.Birthday == "" {
                self.Entrant.passGenerated = false
                throw ErrorsForEmployees.AllDetailsMissing
            } else if self.Entrant.firstName == "" || self.Entrant.firstName == nil {
                throw ErrorsForEmployees.MissingFirstName
            } else if self.Entrant.lastName == "" || self.Entrant.lastName == nil {
                throw ErrorsForEmployees.MissingLastName
            } else if SeniorGuest.Birthday == "" || self.Entrant.Birthday == nil {
                throw ErrorsForGuest.AgeIsMissing
            } else {
                self.Entrant.passGenerated = true
                return true
            }
        } else if Entrant is Guest || Entrant is VIPGuest {
            self.Entrant.passGenerated = true
            return true
        } else {
            return false
        }
    }
    
    
    func swipeAt(area: Area) throws -> Bool {
        
        
        if self.Entrant.passGenerated {
            if area == .Amusement {
                return true
            } else {
                throw swipeErrors.accessDenied
            }
            
        } else {
            throw swipeErrors.passNotGenerated
        }
    }
    
    func swipeAtRide() -> Bool {
        return true
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
            if self.Entrant.discountOffers {
                let dictionaryOfDiscountValues = self.Entrant.availDiscount
                for (key, value) in dictionaryOfDiscountValues {
                    if key == item {
                        discountValue = value
                    }
                }
            }
            
        }
        return discountValue
    }        /*
     guard let passStatus = self.Entrant.passGenerated else {throw swipeErrors.passNotGenerated}
     if passStatus {
     var discountValue: Double = 0.0
     if self.Entrant is VIPGuest {
     guard let VIPEntrant = self.Entrant as? VIPGuest else {return 0.0}
     let dictionaryOfDiscountValues = VIPEntrant.availDiscount
     for (key, value) in dictionaryOfDiscountValues {
     if key == item {
     discountValue = value
     }
     }
     }
     return discountValue
     } else {
     throw swipeErrors.passNotGenerated
     }
     */
}
