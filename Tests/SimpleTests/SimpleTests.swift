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

  func testRawEmpty() throws {
    let raw: UnsafeMutableRawPointer = UnsafeMutableRawPointer.allocate(
      byteCount: 0,
      alignment: 4
    )
    defer {
      raw.deallocate()
    }
    let v: Float32 = Simple.rawFast32f(raw, 0)
    XCTAssertTrue(v.isNaN)
  }

  func testRawSingle() throws {
    let raw: UnsafeMutableRawPointer = UnsafeMutableRawPointer.allocate(
      byteCount: 4,
      alignment: 4
    )
    defer {
      raw.deallocate()
    }
    let v: Float32 = Simple.rawFast32f(raw, 1)
    XCTAssertTrue(v.isNaN)
  }

  func testRawIV() throws {
    let raw: UnsafeMutableRawPointer = UnsafeMutableRawPointer.allocate(
      byteCount: 4 << 2,
      alignment: 4
    )
    defer {
      raw.deallocate()
    }
    let bound: UnsafeMutablePointer<Float32> = raw.assumingMemoryBound(to: Float32.self)
    let buf: UnsafeMutableBufferPointer<Float32> = UnsafeMutableBufferPointer(
      start: bound,
      count: 4
    )
    buf[0] = 1.0
    buf[1] = 2.0
    buf[2] = 2.0
    buf[3] = 2.0

    let iraw: UnsafeRawPointer = UnsafeRawPointer(raw)
    let v: Float32 = Simple.rawFast32f(iraw, 4)
    XCTAssertEqual(v, 0.25)
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

  func testRawEmpty() throws {
    let raw: UnsafeMutableRawPointer = UnsafeMutableRawPointer.allocate(
      byteCount: 0,
      alignment: 4
    )
    defer {
      raw.deallocate()
    }

    let v: Float32 = Simple.rawSlow32f(raw, 0)
    XCTAssertTrue(v.isNaN)
  }

  func testRawSingle() throws {
    let raw: UnsafeMutableRawPointer = UnsafeMutableRawPointer.allocate(
      byteCount: 4,
      alignment: 4
    )
    defer {
      raw.deallocate()
    }
    let v: Float32 = Simple.rawSlow32f(raw, 1)
    XCTAssertTrue(v.isNaN)
  }

  func testRawIV() throws {
    let raw: UnsafeMutableRawPointer = UnsafeMutableRawPointer.allocate(
      byteCount: 4 << 2,
      alignment: 4
    )
    defer {
      raw.deallocate()
    }
    let bound: UnsafeMutablePointer<Float32> = raw.assumingMemoryBound(to: Float32.self)
    let buf: UnsafeMutableBufferPointer<Float32> = UnsafeMutableBufferPointer(
      start: bound,
      count: 4
    )
    buf[0] = 1.0
    buf[1] = 2.0
    buf[2] = 2.0
    buf[3] = 2.0

    let iraw: UnsafeRawPointer = UnsafeRawPointer(raw)
    let v: Float32 = Simple.rawSlow32f(iraw, 4)
    XCTAssertEqual(v, 0.25)
  }
}
