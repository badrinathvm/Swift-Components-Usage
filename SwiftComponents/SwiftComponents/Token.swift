//
//  Token.swift
//  SwiftComponents
//
//  Created by Badrinath on 8/27/17.
//  Copyright © 2017 Badrinath. All rights reserved.
//

import Foundation


class Token{
    
    var token:String?
    var tokenType:String?
    
    init(token:String,tokenType:String){
        self.token = token
        self.tokenType = tokenType
    }
    
    
    init(tokenContent:NSDictionary){
        self.token = tokenContent["access_token"] as? String
        self.tokenType = tokenContent["token_type"] as? String
        
        print(self.token!)
        print(self.tokenType!)
    }
    
//    var tokenValue:String!{
//        didSet{
//            self.token = tokenValue
//        }
//    }
    
}
