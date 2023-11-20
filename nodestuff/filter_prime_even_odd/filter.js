
export default function filter(ary, filterType) {
  return ary.filter(n => {
    switch (filterType) {
      case 'odd':
        return n % 2 === 1
      case 'even':
        return n % 2 === 0
      case 'prime':
        return isPrime(n)
      default:
        throw new Error('invalid filterType')
    }
  })
}

function isPrime(n) {
  let m = n - 1
  while (m > 1) {
    if (n % m == 0) {
      return false
    }
    m = m - 1
  }
  return true
}
