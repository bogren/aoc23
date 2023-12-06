import Foundation
import ArgumentParser

struct Day6: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day6", withExtension: nil, subdirectory: "Input"
  )!

  mutating func run() throws {
    let firstLine = try String(contentsOf: fileURL).split(separator: "\n")[0]
    let secondLine = try String(contentsOf: fileURL).split(separator: "\n")[1]
    let time = firstLine.split(separator: ":")[1]
      .split(separator: " ")
      .map(String.init)
      .compactMap(Int.init)
    let distance = secondLine.split(separator: ":")[1]
      .split(separator: " ")
      .map(String.init)
      .compactMap(Int.init)

    var part1 = 1
    for (t, d) in zip(time, distance) {
      var x = 0
      for i in 1..<t {
        if i * (t - i) > d { x += 1 }
      }
      part1 *= x
    }
    print(part1)

    let t = Int(time.map(String.init).joined())!
    let d = Int(distance.map(String.init).joined())!
    var part2 = 0
    for i in 1..<t { // Slow 🐌
      if i * (t - i) > d {
        part2 += 1
      }
    }
    print(part2)
  }
}

