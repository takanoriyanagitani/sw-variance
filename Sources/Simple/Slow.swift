import CalcVariance

/// Computes variance of 32-bit float values(uses 64-bit float internally)
public func slowVar32f<C>(values: C) -> Float32
where C: Collection<Float32> {
  let cnt: Int = values.count
  let tooFew: Bool = cnt < 2
  let ok: Bool = !tooFew
  guard ok else {
    return Float32.nan
  }

  let cntf: Float64 = Float64(cnt)
  let rcp: Float64 = 1.0 / cntf

  let (sumsq, sum): (Float64, Float64) = values.reduce(
    (0.0, 0.0),
    {
      let (asq, a): (Float64, Float64) = $0
      let next: Float64 = Float64($1)

      return (
        asq + (next * next),
        a + next
      )
    }
  )

  let ratio: Float64 = cntf / (cntf - 1.0)

  let left: Float64 = rcp * sumsq
  let right: Float64 = rcp * sum

  let sub: Float64 = left - right * right

  return Float32(ratio * sub)
}

/// Calculates the variance of `[Float32]`(uses 64-bit float internally).
public let slow32f64: CalcVariance.CalculateVariance32f = {
  let values: [Float32] = $0
  return slowVar32f(values: values)
}

/// Calculates the variance of `UnsafeBufferPointer`(uses 64-bit float internally).
public let bufPtrSlow32f: CalcVariance.CalcVarBufPtr32f = {
  let values: UnsafeBufferPointer<Float32> = $0
  return slowVar32f(values: values)
}

/// Calculates the variance of `UnsafePointer`(uses 64-bit float internally).
public let ptrSlow32f: CalcVariance.CalcVarPtr32f = {
  let values: UnsafePointer<Float32> = $0
  let count: Int = $1
  let buf: UnsafeBufferPointer<Float32> = UnsafeBufferPointer(
    start: values,
    count: count
  )
  return bufPtrSlow32f(buf)
}

/// Calculates the variance of `UnsafeRawPointer`(uses 64-bit float internally).
public let rawSlow32f: CalcVariance.CalcVarRaw32f = {
  let values: UnsafeRawPointer = $0
  let count: Int = $1
  let bound: UnsafePointer<Float32> = values.assumingMemoryBound(
    to: Float32.self
  )
  return ptrSlow32f(bound, count)
}
