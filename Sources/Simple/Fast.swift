import CalcVariance

public func calcVar32f<C>(values: C) -> Float32
where C: Collection<Float32> {
  let cnt: Int = values.count
  let tooFew: Bool = cnt < 2
  let ok: Bool = !tooFew
  guard ok else {
    return Float32.nan
  }

  let cntf: Float32 = Float32(cnt)
  let rcp: Float32 = 1.0 / cntf

  let (sumsq, sum): (Float32, Float32) = values.reduce(
    (0.0, 0.0),
    {
      let (asq, a): (Float32, Float32) = $0
      let next: Float32 = $1

      return (
        asq + (next * next),
        a + next
      )
    }
  )

  let ratio: Float32 = cntf / (cntf - 1.0)

  let left: Float32 = rcp * sumsq
  let right: Float32 = rcp * sum

  let sub: Float32 = left - right * right

  return ratio * sub
}

public let fast32f: CalcVariance.CalculateVariance32f = {
  let values: [Float32] = $0
  return calcVar32f(values: values)
}

public let bufPtrFast32f: CalcVariance.CalcVarBufPtr32f = {
  let values: UnsafeBufferPointer<Float32> = $0
  return calcVar32f(values: values)
}

public let ptrFast32f: CalcVariance.CalcVarPtr32f = {
  let values: UnsafePointer<Float32> = $0
  let count: Int = $1
  let buf: UnsafeBufferPointer<Float32> = UnsafeBufferPointer(
    start: values,
    count: count
  )
  return bufPtrFast32f(buf)
}

public let rawFast32f: CalcVariance.CalcVarRaw32f = {
  let values: UnsafeRawPointer = $0
  let count: Int = $1
  let bound: UnsafePointer<Float32> = values.assumingMemoryBound(
    to: Float32.self
  )
  return ptrFast32f(bound, count)
}
