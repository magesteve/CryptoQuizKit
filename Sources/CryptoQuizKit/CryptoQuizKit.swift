//
//  CryptoQuizKit.swift
//  CryptoQuizKit
//
//  Created by Steve Sheets on 7/3/20.
//  Copyright © 2020 Steve Sheets. All rights reserved.
//

// MARK: Structure

/// Abstract structure defining Cryptoquiz Puzzle static functions
public struct CryptoQuiz {
    
    // MARK: Static Constant

    /// Identiy Key - encryption/descryption with this will return exact results.
    public static let identityKey = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    // MARK: Static Functions

    /// Check if given key is legal (only Scrambled A-Z)
    /// - Parameter key: String to check
    /// - Returns: Bool True if key is legal (26 character, A-Z contained)
    static public func isLegalKey(_ key: String) -> Bool {
        guard key.count==26 else { return false }
        
        let upperCaseKey = key.uppercased()

        for char in CryptoQuiz.identityKey {
            if !upperCaseKey.contains(char) {
                return false
            }
        }
        
        return true
    }

    /// Generate a random Key,
    /// - Returns: String Scrambled Key
    static public func generateKey() -> String {
        let key = CryptoQuiz.identityKey
        
        var a = Array(key)
        
        for spot in 0..<26 {
            let randomSpot = Int.random(in: 0..<26)
            
            let value = a[spot]
            a[spot] = a[randomSpot]
            a[randomSpot] = value
        }
        
        return String(a)
    }
    
    
    /// Private function to reverse a key for description (assume legal uppercase key)
    /// - Parameter key: String key to reverse
    /// - Returns: String key with reverse info
    static public func reverseKey(_ key: String) -> String {
        var resultLetters = Array(key)
        
        let aChar = Int(Unicode.Scalar("A").value)

        var pos = 0
        for letter in key {
            if let a = letter.asciiValue, let u = UnicodeScalar(pos + aChar) {
                let i = Int(a) - aChar
                let c = Character(u)
                resultLetters[i] = c
            }
            
            pos = pos + 1
        }

        return String(resultLetters)
    }
    
    /// Given a legal key, encrypt the given text
    /// - Parameters:
    ///   - text: String text to encrypt. Text does not need to be upper case.
    ///   - key: String legal key
    /// - Returns: String encrypted text (upper case). Empty if key not leval.
    static public func encrypt(text: String, withKey key: String) -> String {
        let upperCaseText = text.uppercased()
        let upperCaseKey = key.uppercased()

        guard CryptoQuiz.isLegalKey(upperCaseKey) else { return "" }
        
        let listLetters = Array(upperCaseKey)

        var results = ""
        
        let aChar = Unicode.Scalar("A").value
        let zChar = Unicode.Scalar("Z").value
        
        for letter in upperCaseText {
            if let value = letter.asciiValue {
                if (value>=aChar) && (value<=zChar) {
                    let newValue = Int(value) - Int(aChar)
                    let char = listLetters[newValue]
                    results.append(char)
              }
                else {
                    results.append(letter)
                }
            }
            else {
                results.append(letter)
            }
        }
        
        return results
    }
    
    /// Given a legal key, decrypt the given text
    /// - Parameters:
    ///   - text: String text to decrypt. Text does not need to be upper case.
    ///   - key: String legal key
    /// - Returns: String decrypted text (upper case). Empty if key not leval.
    static public func decrypt(text: String, withKey key: String) -> String {
        let upperCaseKey = key.uppercased()

        guard CryptoQuiz.isLegalKey(upperCaseKey) else { return "" }
        
        let reverseKey = CryptoQuiz.reverseKey(upperCaseKey)
        
        return encrypt(text: text, withKey: reverseKey)
    }
    
    /// Encrypt the given text, wih random key.
    /// - Parameter text: String text to encrypt. Text does not need to be upper case
    /// - Returns: Tuple with two Strings, containng the encrypted text, and key used. Both will be upper case.
    static public func encrypt(text: String) -> (String, String) {
        let key = CryptoQuiz.generateKey()
        let result = CryptoQuiz.encrypt(text: text, withKey: key)
        return (result, key)
    }

}
