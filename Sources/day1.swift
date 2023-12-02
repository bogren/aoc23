import Foundation
import ArgumentParser

struct Day1: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day1",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let input = try String(contentsOf: fileURL)
    let lines = input.components(separatedBy: .newlines)
    var part1 = 0, part2 = 0
    for line in lines {
      if line.isEmpty { continue }
      var digits1: [Int] = []
      var digits2: [Int] = []
      for (i, c) in line.enumerated() {
        if let digit = c.hexDigitValue, digit < 10 {
          digits1.append(digit)
          digits2.append(digit)
        }
        for (j, a) in "one two three four five six seven eight nine ten"
          .components(separatedBy: .whitespaces)
          .enumerated() {
          if line[String.Index(utf16Offset: i, in: line)...].starts(with: a) {
            digits2.append(j+1)
          }
        }
      }
      part1 += digits1.first! * 10 + digits1.last!
      part2 += digits2.first! * 10 + digits2.last!
    }
    print("part1: \(part1)")
    print("part2: \(part2)")
  }
}
