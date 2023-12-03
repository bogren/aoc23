import Foundation
import ArgumentParser

struct Day3: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day3",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let input = try String(contentsOf: fileURL)
    let grid = input.split(separator: "\n").map { $0.split(separator: "") }
    var coords: [Coordinate: Set<Coordinate>] = [:]
    var gears: [Coordinate: [Coordinate]] = [:]
    for (r, row) in grid.enumerated() {
      for (c, char) in row.enumerated() {
        if char.isNumber || char == "." { continue }
        // Found symbol 🎉 Check if neighbor is number.
        for nr in [r - 1, r, r + 1] {
          for nc in [c - 1, c, c + 1] {
            if nr < 0 || nr >= grid.count ||
                nc < 0 || nc >= grid[nr].count ||
                grid[nr][nc].isNotNumber {
              continue
            }

            // Go backwards from found neighbor
            // 467.
            // ...*
            var pointer = nc
            while pointer > 0 && grid[nr][pointer - 1].isNumber {
              pointer -= 1
            }

            // Add start index for each numbers neighboring a symbol.
            var l = coords[.init(x: r, y: c), default: []]
            l.insert(.init(x: nr, y: pointer))
            coords[.init(x: r, y: c)] = l

            // Add start index for each number for gears - including the location
            if char == "*" {
              var gearList = gears[.init(x: r, y: c), default: []]
              gearList.append(.init(x: nr, y: pointer))
              gears[.init(x: r, y: c)] = gearList
            }
          }
        }
      }
    }
    // Build the numbers from the coordinates.
    var numbers: [Int] = []
    var gearNumbers: [Coordinate: Set<Int>] = [:]
    for (key, coord) in coords {
      for c in coord {
        var temp = ""
        var pointer = c.y
        while pointer < grid[c.y].count && grid[c.x][pointer].isNumber {
          temp += (grid[c.x][pointer])
          pointer += 1
        }
        numbers.append(Int(temp)!)
        var l = gearNumbers[key, default: []]
        l.insert(Int(temp)!)
        gearNumbers[key] = l
      }
    }
    print("part1: \(numbers.reduce(0, +))")

    var part2 = 0
    for (_, pair) in gearNumbers.filter({ $0.value.count == 2}) {
      part2 += pair.reduce(1, *)
    }
    print("part2: \(part2)")
  }
}

struct Coordinate: Hashable {
  let x: Int
  let y: Int
}

extension Substring.SubSequence {
  var isNumber: Bool {
    Character(String(self)).isNumber
  }

  var isNotNumber: Bool {
    !Character(String(self)).isNumber
  }
}
