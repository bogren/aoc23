import Foundation
import ArgumentParser

@main
struct AdventOfCode: ParsableCommand {

  static let configuration = CommandConfiguration(
    abstract: "Solutions to Advent of Code 2023 🎄",
    subcommands: [Day1.self, Day2.self],
    helpNames: .shortAndLong
  )
}
