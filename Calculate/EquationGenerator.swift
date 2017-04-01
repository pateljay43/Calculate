//
//  EquationGenerator.swift
//  Calculate
//
//  Created by JAY PATEL on 3/31/17.
//  Copyright © 2017 Jay Patel. All rights reserved.
//

import Foundation

class EquationGenerator {
    var regex: Regex
    var equation: String
    var result: String
    var strs: [String]
    
    init(regex: Regex) {
        self.regex = regex
        self.strs = regex.splitOnNewLine()
        equation = ""
        result = ""
    }
    
    func generate() {
        for var str in strs {
            str = regex.removeWhiteSpace(str: str)
            if(equation==""){
                if(regex.defaultOp=="-"){
                    equation = equation + regex.defaultOp + str
                } else {
                    equation = equation + str
                }
            }else{
                if(str.characters.count>0){
                    if(regex.numberOfMatches(str: str, range: NSRange.init(location: 0, length: 1), pat: regex.operands)>0){
                        equation = equation + str
                    } else {
                        equation = equation + regex.defaultOp + str
                    }
                }
            }
        }
        
    }
    
    func evaluateEquation() -> Bool{
        if(equation != ""){
            let eq: NSExpression = NSExpression.init(format: equation)
            result = String.init(format: "%.2f", eq.expressionValue(with: nil, context: nil) as! Double)
            return true
        }
        return false
    }
}
