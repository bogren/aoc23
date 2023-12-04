import Foundation
import ArgumentParser

struct Day4: ParsableCommand {
  private var fileURL = Bundle.module.url(
    forResource: "day4", withExtension: nil, subdirectory: "Input"
  )!

  struct Card {
    let id: Int
    let wins: [String]
    let numbers: [String]
  }

  mutating func run() throws {
    let input = try String(contentsOf: fileURL).split(separator: "\n")
    var cards: [Card] = []
    for line in input {
      let id = Int(line.split(separator: "|")[0].split(separator: ":")[0]
        .split(separator: " ")[1])!
      let wins = line.split(separator: "|")[0].split(separator: ":")[1]
        .split(separator: " ")
        .map(String.init)
      let numbers = line.split(separator: "|")[1]
        .split(separator: " ")
        .map(String.init)
      cards.append(Card(id: id, wins: wins, numbers: numbers))
    }

    var part1: Decimal = 0 // Swift 👌
    var pile: [Int: Int] = [:]

    for card in cards {
      pile[card.id, default: 0] += 1 // Add each starting card
      let numOfWins = Set(card.numbers).intersection(card.wins).count

      if numOfWins > 0 {
        part1 += pow(2, numOfWins - 1) // 1, 2, 4, 8
      }

      for i in 0..<numOfWins {
        pile[card.id + i + 1, default: 0] += pile[card.id, default: 0]
      }
    }

    print("part 1: \(part1)")
    print("part 2: \(pile.values.reduce(0, +))")
  }
}
