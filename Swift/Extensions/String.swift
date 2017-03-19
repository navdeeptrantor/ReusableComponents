//
//  Extensions.swift
//  NODAT
//
//  Created by NavdeepSingh on 28/02/17.
//  Copyright © 2017 Trantor Inc. All rights reserved.
//

import Foundation

extension String {
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var trimmedWhiteSpaces:String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    var length: Int {
        return self.characters.count
    }
   
    
    /* Password must be a minimum of 8 characters with at least one special character or numeric, at least one uppercase letter & at least one lower case letter. */
    
    var isValidPassword: Bool {
        let passwordRegEx = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!])(?=\\S+$).{8,}$"
        let passwordTest  = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    
    
}
