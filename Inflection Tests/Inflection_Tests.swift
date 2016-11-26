//
//  Inflection_Tests.swift
//  Inflection Tests
//
//  Created by Christoffer Winterkvist on 3/2/15.
//
//

import UIKit
import XCTest

class Inflection_Tests: XCTestCase {
    
    func testRubyToSwift() {
        let subjectString = "createdAt".rubyCase()
        let expectedString = "created_at"
        
        XCTAssertEqual(subjectString, expectedString, "New string should be 'created_at'")
    }
    
    func testSwiftToRuby() {
        let subjectString = "updated_at".swiftCase()
        let expectedString = "updatedAt"
        
        XCTAssertEqual(subjectString, expectedString, "New string should be 'createdAt'")
    }
    
    func testDictionaryInflection() {
        let remoteDictionary = ["created_at":"", "updated_at":""]
        let localDictionary = ["createdAt":"", "updatedAt":""]

        XCTAssertEqual((remoteDictionary as NSDictionary).swiftCase(), localDictionary as NSDictionary)
    }
    
}
