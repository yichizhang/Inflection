//
//  Inflection.swift
//  Inflection
//
//  Created by Christoffer Winterkvist on 3/2/15.
//
//

import Foundation

public extension NSDictionary {
    
    func swiftCase() -> NSDictionary {
        return self.inflectDictionaryKeys({ (string) -> String in string.swiftCase()})
    }
    
    func rubyCase() -> NSDictionary {
        return self.inflectDictionaryKeys({ (string) -> String in string.rubyCase()})
    }
    
    fileprivate func inflectDictionaryKeys(_ closure: @escaping (_ string: String) -> String) -> NSDictionary {
        let newDictionary = NSMutableDictionary()
        self.forEach { newDictionary[closure($0 as! String)] = $1 }

        return newDictionary.copy() as! NSDictionary
    }
    
}

public extension String {
    
    func camelCase() -> String {
        return self.replaceIdentifierWithString("").lowerCaseFirstLetter()
    }
    
    func classify() -> String {
        return self.upperCamelCase()
    }
    
    func dashedCase() -> String {
        return self.lowerCaseFirstLetter().replaceIdentifierWithString("-")
    }
    
    func dotNetCase() -> String {
        return self.upperCamelCase()
    }
    
    func javascriptCase() -> String {
        return self.replaceIdentifierWithString("").lowerCaseFirstLetter()
    }
    
    func lispCase() -> String {
        return self.dashedCase()
    }
    
    func objcCase() -> String {
        return self.camelCase()
    }
    
    func pythonCase() -> String {
        return self.snakeCase()
    }
    
    func snakeCase() -> String {
        return self.underscoreCase()
    }
    
    func swiftCase() -> String {
        return self.camelCase()
    }
    
    func underscoreCase() -> String {
        return (self.lowerCaseFirstLetter() as String).replaceIdentifierWithString("_")
    }
    
    func upperCamelCase() -> String {
        return self.camelCase().upperCamelCase()
    }
    
    func rubyCase () -> String {
        return self.snakeCase()
    }
    
    func humanize() -> String {
        return self.replaceIdentifierWithString(" ").capitalized
    }
    
    fileprivate func lowerCaseFirstLetter() -> String {
        let mutableString = self.mutableCopy() as! NSMutableString
        mutableString.replaceCharacters(in: NSMakeRange(0, 1), with: self.firstLetter().lowercased() as String)

        return mutableString.copy() as! String
    }
    
    fileprivate func upperCaseFirstLetter() -> String {
        let mutableString = self.mutableCopy() as! NSMutableString
        mutableString.replaceCharacters(in: NSMakeRange(0, 1), with: self.firstLetter().uppercased() as String)
        
        return mutableString.copy() as! String
    }
    
    fileprivate func firstLetter() -> String {
        return (self as NSString).substring(to: 1) as String
    }
    
    fileprivate func replaceIdentifierWithString(_ identifier: String) -> String {

        let scanner = Scanner.init(string: self)
        let identifierSet = CharacterSet.init(charactersIn: identifier)
        let alphaNumericSet = CharacterSet.alphanumerics
        let uppercaseSet = CharacterSet.uppercaseLetters
        let lowercaseSet = CharacterSet.lowercaseLetters
        
        var buffer: NSString?
        let output: NSMutableString = NSMutableString()

        scanner.caseSensitive = true
        
        while !scanner.isAtEnd {
            if scanner.scanCharacters(from: identifierSet, into: &buffer) {
                continue
            } else if !identifier.isEmpty {
                let isUppercase: Bool = scanner.scanCharacters(from: uppercaseSet, into: &buffer)
                if isUppercase {
                    output.append(identifier)
                    output.append(buffer!.lowercased)
                }
                
                let isLowercase: Bool = scanner.scanCharacters(from: lowercaseSet, into: &buffer)
                if isLowercase {
                    output.append(buffer!.lowercased)
                }
            } else if scanner.scanCharacters(from: alphaNumericSet, into: &buffer) {
                output.append(buffer!.capitalized)
            } else {
                scanner.scanLocation = scanner.scanLocation + 1
            }
            
        }

        return output.copy() as! String
    }
    
}
