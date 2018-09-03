//
//  JWTTests.swift
//
//  Copyright (c) 2016-present, LINE Corporation. All rights reserved.
//
//  You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
//  copy and distribute this software in source code or binary form for use
//  in connection with the web services and APIs provided by LINE Corporation.
//
//  As with any software that integrates with the LINE Corporation platform, your use of this software
//  is subject to the LINE Developers Agreement [http://terms2.line.me/LINE_Developers_Agreement].
//  This copyright notice shall be included in all copies or substantial portions of the software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import XCTest
@testable import LineSDK

// Private Key for test cases in this file:
/*
 
-----BEGIN RSA PRIVATE KEY-----
MIICWwIBAAKBgQDdlatRjRjogo3WojgGHFHYLugdUWAY9iR3fy4arWNA1KoS8kVw
33cJibXr8bvwUAUparCwlvdbH6dvEOfou0/gCFQsHUfQrSDv+MuSUMAe8jzKE4qW
+jK+xQU9a03GUnKHkkle+Q0pX/g6jXZ7r1/xAK5Do2kQ+X5xK9cipRgEKwIDAQAB
AoGAD+onAtVye4ic7VR7V50DF9bOnwRwNXrARcDhq9LWNRrRGElESYYTQ6EbatXS
3MCyjjX2eMhu/aF5YhXBwkppwxg+EOmXeh+MzL7Zh284OuPbkglAaGhV9bb6/5Cp
uGb1esyPbYW+Ty2PC0GSZfIXkXs76jXAu9TOBvD0ybc2YlkCQQDywg2R/7t3Q2OE
2+yo382CLJdrlSLVROWKwb4tb2PjhY4XAwV8d1vy0RenxTB+K5Mu57uVSTHtrMK0
GAtFr833AkEA6avx20OHo61Yela/4k5kQDtjEf1N0LfI+BcWZtxsS3jDM3i1Hp0K
Su5rsCPb8acJo5RO26gGVrfAsDcIXKC+bQJAZZ2XIpsitLyPpuiMOvBbzPavd4gY
6Z8KWrfYzJoI/Q9FuBo6rKwl4BFoToD7WIUS+hpkagwWiz+6zLoX1dbOZwJACmH5
fSSjAkLRi54PKJ8TFUeOP15h9sQzydI8zJU+upvDEKZsZc/UhT/SySDOxQ4G/523
Y0sz/OZtSWcol/UMgQJALesy++GdvoIDLfJX5GBQpuFgFenRiRDabxrE9MNUZ2aP
FaFp+DyAe+b4nDwuJaW2LURbr8AEZga7oQj0uYxcYw==
-----END RSA PRIVATE KEY-----
 
*/

let pubKey = """
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDdlatRjRjogo3WojgGHFHYLugd
UWAY9iR3fy4arWNA1KoS8kVw33cJibXr8bvwUAUparCwlvdbH6dvEOfou0/gCFQs
HUfQrSDv+MuSUMAe8jzKE4qW+jK+xQU9a03GUnKHkkle+Q0pX/g6jXZ7r1/xAK5D
o2kQ+X5xK9cipRgEKwIDAQAB
-----END PUBLIC KEY-----
"""


/*
 {
 "alg": "RS256",
 "typ": "JWT"
 }.
 {
 "sub": "1234567890",
 "name": "John Doe",
 "admin": true,
 "iat": 1516239022
 }
 */
let sample = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.TCYt5XsITJX1CxPCT8yAV-TVkIEq_PbChOMqsLfRoPsnsgw5WEuts01mq-pQy7UJiN5mgRxD-WUcX16dUEMGlv50aqzpqh4Qktb3rk-BuQy72IFLOqV0G_zS245-kronKb78cPN25DGlcTwLtjPAYuNzVBAh4vGHSrQyHUdBBPM"

/*
 {
   "alg": "RS256",
   "typ": "JWT",
   "kid": "12345"
 }.
 {
   "iss": "https://access.line.me",
   "sub": "U1234567890abcdef1234567890abcdef",
   "aud": "12345",
   "exp": 1535959870,
   "iat": 1535959770,
   "nonce": "ABCABC",
   "name": "onevcat",
   "picture": "https://obs-beta.line-apps.com/xxxx",
   "email": "abc@def.com"
 }
*/
let LINEIDToken = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjEyMzQ1In0.eyJpc3MiOiJodHRwczovL2FjY2Vzcy5saW5lLm1lIiwic3ViIjoiVTEyMzQ1Njc4OTBhYmNkZWYxMjM0NTY3ODkwYWJjZGVmIiwiYXVkIjoiMTIzNDUiLCJleHAiOjE1MzU5NTk4NzAsImlhdCI6MTUzNTk1OTc3MCwibm9uY2UiOiJBQkNBQkMiLCJuYW1lIjoib25ldmNhdCIsInBpY3R1cmUiOiJodHRwczovL29icy1iZXRhLmxpbmUtYXBwcy5jb20veHh4eCIsImVtYWlsIjoiYWJjQGRlZi5jb20ifQ.F_Y8w5rqQEdzrjxhps4EJYUf0choZ9Mu7Uq-WMQ2sGIJDpWOIxu4DjGN-jYOeW_1ndJ9tFwUwXA26Gobawjirf4Y9WvGQiC7mevpkilAB8kL7sBILJ2pjmryJPagaFto0yAv0e2_UQjGSgZnElU2k2UbViAdfzIEC0XKy_PApFM"

class JWTTests: XCTestCase {

    func testJWTCreating() {
        let data = Data(sample.utf8)
        let token = try! JWT(data: data)
        XCTAssertEqual(token.header.algorithm, "RS256")
        XCTAssertEqual(token.header.tokenType, "JWT")
        
        XCTAssertEqual(token.payload["name", String.self], "John Doe")
        XCTAssertEqual(token.payload["iat", Int64.self], 1516239022)
    }
    
    func testJWTSignatureVerify() {
        let data = Data(sample.utf8)
        let token = try! JWT(data: data)
        
        let key = try! RSA.PublicKey(pem: pubKey)
        let result = try! token.verify(with: key)
        XCTAssertTrue(result)
    }

    func testJWTValueVerify() {
        let data = Data(LINEIDToken.utf8)
        let token = try! JWT(data: data)
        
        let payload = token.payload

        XCTAssertNoThrow(try payload.verify(keyPath: \.issuer, expected: "https://access.line.me"))
        XCTAssertNoThrow(try payload.verify(keyPath: \.subject, expected: "U1234567890abcdef1234567890abcdef"))
        XCTAssertNoThrow(try payload.verify(keyPath: \.audience, expected: "12345"))
        
        let valid = Date(timeIntervalSince1970: 1535959800)
        XCTAssertNoThrow(try payload.verify(keyPath: \.expiration, laterThan: valid))
        XCTAssertNoThrow(try payload.verify(keyPath: \.issueAt, earlierThan: valid))
        XCTAssertNoThrow(try payload.verify(keyPath: \.issueAt, earlierThan: payload.expiration!))
        
        let past = Date.distantPast
        XCTAssertNoThrow(try payload.verify(keyPath: \.expiration, laterThan: past))
        XCTAssertThrowsError(try payload.verify(keyPath: \.issueAt, earlierThan: past))
        
        let future = Date.distantFuture
        XCTAssertThrowsError(try payload.verify(keyPath: \.expiration, laterThan: future))
        XCTAssertNoThrow(try payload.verify(keyPath: \.issueAt, earlierThan: future))
        
        XCTAssertEqual(payload.name, "onevcat")
        XCTAssertEqual(payload.email, "abc@def.com")
        XCTAssertEqual(payload.picture?.absoluteString, "https://obs-beta.line-apps.com/xxxx")
    }
}
