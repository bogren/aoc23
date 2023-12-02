import Foundation
import ArgumentParser

struct Day2: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day2",
    withExtension: nil,
    subdirectory: "Input"
  )!

  mutating func run() throws {
    let data = try String(contentsOf: fileURL)
    let bag = ["red": 12, "green": 13, "blue": 14]
    let lines = data.components(separatedBy: .newlines)
    var part1 = 0, part2 = 0
    for (i, line) in lines.enumerated() {
      if line.isEmpty { continue }
      var validGame = true
      var hRed = 1, hGreen = 1, hBlue = 1
      for game in line.components(separatedBy: ":").last!.components(separatedBy: ";") {
        for draws in game.components(separatedBy: ",") {
          let color = draws.components(separatedBy: .whitespaces)[2]
          let amount = Int(draws.components(separatedBy: .whitespaces)[1])!
          if bag[color]! < amount { validGame = false }
          switch color {
          case "red": hRed = max(hRed, amount)
          case "green": hGreen = max(hGreen, amount)
          case "blue": hBlue = max(hBlue, amount)
          default: break
          }
        }
      }
      part1 += validGame ? (i + 1) : 0
      part2 += hRed * hGreen * hBlue
    }
    print("part1: \(part1)")
    print("part2: \(part2)")
  }
}
