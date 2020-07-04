import XCTest
@testable import CryptoQuizKit

final class CryptoQuizTests: XCTestCase {
    
    let keyPlusOne = "BCDEFGHIJKLMNOPQRSTUVWXYZA"

    let keyMinusOne = "ZABCDEFGHIJKLMNOPQRSTUVWXY"

    func testIdentityKey() {
        let expected = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        XCTAssertEqual(CryptoQuiz.identityKey, expected, "IdentityKey checked")
    }
    
    func testIsLegalKey() {
        var key = ""
        
        key = "ABCD"
        XCTAssertFalse(CryptoQuiz.isLegalKey(key), "Is Not Legal 1")

        key = "ABCDEFGHIJKLMNOPQRSTUVWXYA"
        XCTAssertFalse(CryptoQuiz.isLegalKey(key), "Is Not Legal 2")
        
        key = CryptoQuiz.generateKey()
        XCTAssert(CryptoQuiz.isLegalKey(key), "Is Legal 1")

        key = CryptoQuiz.generateKey()
        XCTAssert(CryptoQuiz.isLegalKey(key), "Is Legal 2")

        key = "BCDEFGHIJKLMNOPQRSTUVWXYZA"
        XCTAssert(CryptoQuiz.isLegalKey(key), "Is Legal 3")

        key = CryptoQuiz.generateKey()
        XCTAssert(CryptoQuiz.isLegalKey(key), "Is Legal 4")

    }

    func testGenerateKey() {
        var key = ""
        
        key = CryptoQuiz.generateKey()
        XCTAssert(CryptoQuiz.isLegalKey(key), "Gemerated Key test 1")

        key = CryptoQuiz.generateKey()
        XCTAssert(CryptoQuiz.isLegalKey(key), "Gemerated Key test 2")

        key = CryptoQuiz.generateKey()
        XCTAssert(CryptoQuiz.isLegalKey(key), "Gemerated Key test 3")
    }

    func testReverseKey() {
        var key = ""
            
        key = CryptoQuiz.reverseKey(keyPlusOne)
        XCTAssertEqual(key, keyMinusOne, "Reverse Key Test 1")

        key = CryptoQuiz.reverseKey(keyMinusOne)
        XCTAssertEqual(key, (keyPlusOne), "Reverse Key Test 2")
    }

    func testEncrypt() {
        var result = ""
        
        result = CryptoQuiz.encrypt(text: "THIS IS A TEST", withKey: CryptoQuiz.identityKey)
        XCTAssertEqual(result, "THIS IS A TEST", "Encryption test 1")

        result = CryptoQuiz.encrypt(text: "TEST", withKey: keyPlusOne)
        XCTAssertEqual(result, "UFTU", "Encryption test 2")

        result = CryptoQuiz.encrypt(text: "TEST", withKey: keyPlusOne)
        XCTAssertEqual(result, "UFTU", "Encryption test 2")
    }

    func testDecrypt() {
        var result = ""
        
        result = CryptoQuiz.decrypt(text: "THIS IS A TEST", withKey: CryptoQuiz.identityKey)
        XCTAssertEqual(result, "THIS IS A TEST", "Decryption test 1")

        result = CryptoQuiz.decrypt(text: "UFTU", withKey: keyPlusOne)
        XCTAssertEqual(result, "TEST", "Decryption test 2")
    }
    
    func testEncryptDescrypt() {
        var key = ""
        var result = ""
        var text = ""

        (text, key) = CryptoQuiz.encrypt(text: CryptoQuiz.identityKey)
        XCTAssertEqual(text, key, "Encrypt/Decrypt test 1a")
        result = CryptoQuiz.decrypt(text: text, withKey: key)
        XCTAssertEqual(result, CryptoQuiz.identityKey, "Encrypt/Decrypt test 1b")

        (text, key) = CryptoQuiz.encrypt(text: "This is a test")
        result = CryptoQuiz.decrypt(text: text, withKey: key)
        XCTAssertEqual(result, "THIS IS A TEST", "Encrypt/Decrypt test 2")

        (text, key) = CryptoQuiz.encrypt(text: "Now is the time, for all good men...")
        result = CryptoQuiz.decrypt(text: text, withKey: key)
        XCTAssertEqual(result, "NOW IS THE TIME, FOR ALL GOOD MEN...", "Encrypt/Decrypt test 3")

    }

    static var allTests = [
        ("testIdentityKey", testIdentityKey),
        ("testIsLegalKey", testIsLegalKey),
        ("testGenerateKey", testGenerateKey),
        ("testReverseKey", testReverseKey),
        ("testEncrypt", testEncrypt),
        ("testDecrypt", testDecrypt),
        ("testEncryptDescrypt", testEncryptDescrypt),
    ]
}
