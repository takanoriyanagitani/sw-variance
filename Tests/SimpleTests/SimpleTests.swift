import XCTest

@testable import CalcVariance
@testable import Simple

final class FastTests: XCTestCase {

  func testEmpty() throws {
    let calcVar: CalcVariance.CalculateVariance32f = Simple.fast32f
    let empty: [Float32] = []
    let v: Float32 = calcVar(empty)
    XCTAssertTrue(v.isNaN)
  }

  func testSingle() throws {
    let calcVar: CalcVariance.CalculateVariance32f = Simple.fast32f
    let single: [Float32] = [42.0]
    let v: Float32 = calcVar(single)
    XCTAssertTrue(v.isNaN)
  }

  func testDouble() throws {
    let calcVar: CalcVariance.CalculateVariance32f = Simple.fast32f
    let double: [Float32] = [42.0, 24.0]
    let v: Float32 = calcVar(double)
    XCTAssertEqual(v, 162.0)
  }

}

final class SlowTests: XCTestCase {

  func testEmpty() throws {
    let calcVar: CalcVariance.CalculateVariance32f = Simple.slow32f64
    let empty: [Float32] = []
    let v: Float32 = calcVar(empty)
    XCTAssertTrue(v.isNaN)
  }

  func testSingle() throws {
    let calcVar: CalcVariance.CalculateVariance32f = Simple.slow32f64
    let single: [Float32] = [42.0]
    let v: Float32 = calcVar(single)
    XCTAssertTrue(v.isNaN)
  }

  func testDouble() throws {
    let calcVar: CalcVariance.CalculateVariance32f = Simple.slow32f64
    let double: [Float32] = [42.0, 24.0]
    let v: Float32 = calcVar(double)
    XCTAssertEqual(v, 162.0)
  }

}
