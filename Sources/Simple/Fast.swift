import CalcVariance

public let fast32f: CalcVariance.CalculateVariance32f = {
  let values: [Float32] = $0

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

public let slow32f64: CalcVariance.CalculateVariance32f = {
  let values: [Float32] = $0

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
