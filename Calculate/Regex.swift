//
//  Regex.swift
//  Calculate
//
//  Created by JAY PATEL on 3/31/17.
//  Copyright © 2017 Jay Patel. All rights reserved.
//

import Foundation

class Regex {
    
    let blankPat = "[ ]+"
    let whitespace = "\\s"
    let blankBrackets = "\\[\\s*]|\\(\\s*\\)|\\{\\s*\\}|<\\s*>"
    let operands = "-|\\+|\\*|\\/|%"
    let letters = "[a-zA-Z]"
    let chars = "&|\\||\\?|@|;|:|,|'|!|#|\\$|\\^"
    
    var text: String
    var reg: NSRegularExpression
    var defaultOp: String
    
    public init(text: String) {
        reg = NSRegularExpression.init()
        defaultOp = String.init()
        self.text = text
    }
    
    func parse() {
        removeLetters()
        replaceMultipleToSingleSpace()
        setDefaultOperand()
        removeBlankBrackets()
    }
    
    private func removeLetters() {
        reg = try! NSRegularExpression.init(pattern: letters, options: [])
        text = reg.stringByReplacingMatches(in: text, options: [], range: NSRange.init(location: 0, length: text.characters.count), withTemplate: "")
        reg = try! NSRegularExpression.init(pattern: chars, options: [])
        text = reg.stringByReplacingMatches(in: text, options: [], range: NSRange.init(location: 0, length: text.characters.count), withTemplate: "\n")
    }
    
    private func replaceMultipleToSingleSpace() {
        reg = try! NSRegularExpression(pattern: blankPat, options: [])
        text = reg.stringByReplacingMatches(in: text, options: [], range: NSRange.init(location: 0, length: text.characters.count), withTemplate: " ")
        text = text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    private func setDefaultOperand() {
        reg = try! NSRegularExpression.init(pattern: "-", options: [])
        let subOp: Int = reg.numberOfMatches(in: text, options: [], range: NSRange.init(location: 0, length: text.characters.count))
        reg = try! NSRegularExpression.init(pattern: "\\+", options: [])
        let addOp: Int = reg.numberOfMatches(in: text, options: [], range: NSRange.init(location: 0, length: text.characters.count))
        
        defaultOp = "+"
        if(subOp==0 && addOp==0){
            defaultOp = "+"
        } else if(subOp==0){
            defaultOp = "-"
        } else if(addOp==0){
            defaultOp = "+"
        }
    }
    
    private func removeBlankBrackets() {
        reg = try! NSRegularExpression.init(pattern: blankBrackets, options: [])
        text = reg.stringByReplacingMatches(in: text, options: [], range: NSRange.init(location: 0, length: text.characters.count), withTemplate: "")
    }
    
    func splitOnNewLine() -> [String]{
        return text.characters.split(separator: "\n").map(String.init)
    }
    
    func removeWhiteSpace( str: String) -> String {
        reg = try! NSRegularExpression.init(pattern: whitespace, options: [])
        return reg.stringByReplacingMatches(in: str, options: [], range: NSRange.init(location: 0, length: str.characters.count), withTemplate: "")
    }
    
    func numberOfMatches( str: String, range: NSRange, pat: String) -> Int{
        reg = try! NSRegularExpression.init(pattern: pat, options: [])
        return reg.numberOfMatches(in: str, options: [], range: range)
    }
    
    //    func removeFollowingOperand(str: String) -> String {
    //        var str = str
    //        while(str.characters.count > 0 && regex.numberOfMatches(in: str, options: [], range: NSRange.init(location: str.characters.count-1, length: str.characters.count))>0){
    //            str = regex.stringByReplacingMatches(in: str, options: [], range: NSRange.init(location: str.characters.count-1, length: str.characters.count), withTemplate: "")
    //        }
    //        return str
    //    }
}
