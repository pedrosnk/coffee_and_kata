import filter from './filter.js'

describe('filter odd', () => {
  it('for only odd array', () => {
    expect(filter([1, 3, 5], 'odd')).toStrictEqual([1, 3, 5])
  })


  it('empty array for strict even', () => {
    expect(filter([2, 4, 6, 8, 10], 'odd')).toStrictEqual([])
  })


  it('filters only odd', () => {
    expect(
      filter([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 'odd'))
      .toStrictEqual([1, 3, 5, 7, 9])
  })
})

describe('filter even', () => {
  it('for only even array', () => {
    expect(filter([2, 4, 6], 'even')).toStrictEqual([2, 4, 6])
  })

  it('for only odd array', () => {
    expect(filter([1, 3, 5], 'even')).toStrictEqual([])
  })

  it('filters only even', () => {
    expect(
      filter([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 'even'))
      .toStrictEqual([2, 4, 6, 8, 10])
  })
})

describe('filter prime numbers', () => {
  it('prime numbers', () => {
    expect(
      filter([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 'prime'))
      .toStrictEqual([1, 2, 3, 5, 7])
  })
})
