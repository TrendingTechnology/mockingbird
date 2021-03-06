//
//  OverloadedMethodTests.swift
//  MockingbirdTests
//
//  Created by Andrew Chang on 8/25/19.
//

import XCTest
import Mockingbird
@testable import MockingbirdTestsHost

class OverloadedMethodTests: XCTestCase {
  
  var classMock: OverloadedMethodsClassMock!
  var protocolMock: OverloadedMethodsProtocolMock!
  
  override func setUp() {
    classMock = mock(OverloadedMethodsClass.self)
    protocolMock = mock(OverloadedMethodsProtocol.self)
  }
  
  func callOverloadedParametersMethod(on classMock: OverloadedMethodsClass,
                                      param1: Bool = true,
                                      param2: Bool = true) -> Bool {
    return classMock.overloadedParameters(param1: param1, param2: param2)
  }
  func callOverloadedParametersMethod(on protocolMock: OverloadedMethodsProtocol,
                                      param1: Bool = true,
                                      param2: Bool = true) -> Bool {
    return protocolMock.overloadedParameters(param1: param1, param2: param2)
  }
  
  func callOverloadedParametersMethod(on classMock: OverloadedMethodsClass,
                                      param1: Int = 1,
                                      param2: Int = 1) -> Bool {
    return classMock.overloadedParameters(param1: param1, param2: param2)
  }
  func callOverloadedParametersMethod(on protocolMock: OverloadedMethodsProtocol,
                                      param1: Int = 1,
                                      param2: Int = 1) -> Bool {
    return protocolMock.overloadedParameters(param1: param1, param2: param2)
  }
  
  func callOverloadedReturnTypeMethod(on classMock: OverloadedMethodsClass) -> Bool {
    return classMock.overloadedReturnType()
  }
  func callOverloadedReturnTypeMethod(on protocolMock: OverloadedMethodsProtocol) -> Bool {
    return protocolMock.overloadedReturnType()
  }
  
  func callOverloadedReturnTypeMethod(on classMock: OverloadedMethodsClass) -> Int {
    return classMock.overloadedReturnType()
  }
  func callOverloadedReturnTypeMethod(on protocolMock: OverloadedMethodsProtocol) -> Int {
    return protocolMock.overloadedReturnType()
  }
  
  func testOverloadedMethod_classMock_overloadedParameters() {
    given(classMock.overloadedParameters(param1: any(Bool.self), param2: any())) ~> true
    given(classMock.overloadedParameters(param1: any(Int.self), param2: any())) ~> false
    XCTAssertTrue(callOverloadedParametersMethod(on: classMock, param1: true, param2: false))
    XCTAssertFalse(callOverloadedParametersMethod(on: classMock, param1: 1, param2: 2))
    verify(classMock.overloadedParameters(param1: any(Bool.self), param2: any())).wasCalled()
    verify(classMock.overloadedParameters(param1: any(Int.self), param2: any())).wasCalled()
  }
  func testOverloadedMethod_protocolMock_overloadedParameters() {
    given(protocolMock.overloadedParameters(param1: any(Bool.self), param2: any())) ~> true
    given(protocolMock.overloadedParameters(param1: any(Int.self), param2: any())) ~> false
    XCTAssertTrue(callOverloadedParametersMethod(on: protocolMock, param1: true, param2: false))
    XCTAssertFalse(callOverloadedParametersMethod(on: protocolMock, param1: 1, param2: 2))
    verify(protocolMock.overloadedParameters(param1: any(Bool.self), param2: any())).wasCalled()
    verify(protocolMock.overloadedParameters(param1: any(Int.self), param2: any())).wasCalled()
  }
  
  func testOverloadedMethod_classMock_overloadedReturnType() {
    given(classMock.overloadedReturnType()) ~> true
    given(classMock.overloadedReturnType()) ~> 1
    XCTAssert(callOverloadedReturnTypeMethod(on: classMock) == true)
    XCTAssert(callOverloadedReturnTypeMethod(on: classMock) == 1)
    verify(classMock.overloadedReturnType()).returning(Bool.self).wasCalled()
    verify(classMock.overloadedReturnType()).returning(Int.self).wasCalled()
  }
  func testOverloadedMethod_protocolMock_overloadedReturnType() {
    given(protocolMock.overloadedReturnType()) ~> true
    given(protocolMock.overloadedReturnType()) ~> 1
    XCTAssert(callOverloadedReturnTypeMethod(on: protocolMock) == true)
    XCTAssert(callOverloadedReturnTypeMethod(on: protocolMock) == 1)
    verify(protocolMock.overloadedReturnType()).returning(Bool.self).wasCalled()
    verify(protocolMock.overloadedReturnType()).returning(Int.self).wasCalled()
  }
  
  func testOverloadedMethod_classMock_overloadedParameters_separateInvocationCounts() {
    given(classMock.overloadedParameters(param1: any(Bool.self), param2: any())) ~> true
    given(classMock.overloadedParameters(param1: any(Int.self), param2: any())) ~> false
    XCTAssertTrue(callOverloadedParametersMethod(on: classMock, param1: true, param2: false))
    verify(classMock.overloadedParameters(param1: any(Bool.self), param2: any())).wasCalled()
    verify(classMock.overloadedParameters(param1: any(Int.self), param2: any())).wasNeverCalled()
  }
  func testOverloadedMethod_protocolMock_overloadedParameters_separateInvocationCounts() {
    given(protocolMock.overloadedParameters(param1: any(Bool.self), param2: any())) ~> true
    given(protocolMock.overloadedParameters(param1: any(Int.self), param2: any())) ~> false
    XCTAssertTrue(callOverloadedParametersMethod(on: protocolMock, param1: true, param2: false))
    verify(protocolMock.overloadedParameters(param1: any(Bool.self), param2: any())).wasCalled()
    verify(protocolMock.overloadedParameters(param1: any(Int.self), param2: any())).wasNeverCalled()
  }
  
  func testOverloadedMethod_classMock_overloadedReturnType_separateInvocationCounts() {
    given(classMock.overloadedReturnType()) ~> true
    given(classMock.overloadedReturnType()) ~> 1
    XCTAssert(callOverloadedReturnTypeMethod(on: classMock) == true)
    verify(classMock.overloadedReturnType()).returning(Bool.self).wasCalled()
    verify(classMock.overloadedReturnType()).returning(Int.self).wasNeverCalled()
  }
  func testOverloadedMethod_protocolMock_overloadedReturnType_separateInvocationCounts() {
    given(protocolMock.overloadedReturnType()) ~> true
    given(protocolMock.overloadedReturnType()) ~> 1
    XCTAssert(callOverloadedReturnTypeMethod(on: protocolMock) == true)
    verify(protocolMock.overloadedReturnType()).returning(Bool.self).wasCalled()
    verify(protocolMock.overloadedReturnType()).returning(Int.self).wasNeverCalled()
  }
}
