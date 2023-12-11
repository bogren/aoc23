import Foundation
import ArgumentParser

struct Day11: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day11", withExtension: nil, subdirectory: "Input"
  )!

  mutating func run() throws {
    let grid = try String(contentsOf: fileURL)
      .split(separator: "\n")
      .map { $0.split(separator: "") }

    var emptyRows: Set<Int> = []
    var emptyCols: Set<Int> = []
    for (r, row) in grid.enumerated() {
      if row.allSatisfy({ $0 == "." }) {
        emptyRows.insert(r)
      }
    }
    for c in 0..<grid[0].count {
      if grid[column: c].allSatisfy({ $0 == "." }) {
        emptyCols.insert(c)
      }
    }
    print(emptyRows)
    print(emptyCols)

    var galaxies: [Coordinate] = []
    for (r, _) in grid.enumerated() {
      for (c, _) in grid[r].enumerated() {
        if grid[r][c] == "#" {
          galaxies.append(Coordinate(x: r, y: c))
        }
      }
    }
    print(galaxies)

    var part1 = 0
    var part2 = 0
    for g1 in galaxies {
      for g2 in galaxies {
        if g1 == g2 { break }
        for r in min(g1.x, g2.x)..<max(g1.x, g2.x) { // Make sure to check valid range 💥
          part1 += emptyRows.contains(r) ? 2 : 1
          part2 += emptyRows.contains(r) ? 1_000_000 : 1
        }
        for c in min(g1.y, g2.y)..<max(g1.y, g2.y) {
          part1 += emptyCols.contains(c) ? 2 : 1
          part2 += emptyCols.contains(c) ? 1_000_000 : 1
        }
      }
    }
    print(part1)
    print(part2)
  }
}

extension Array where Element: Collection {
  subscript(column column: Element.Index) -> [Element.Iterator.Element] {
    return map { $0[column] }
  }
}

