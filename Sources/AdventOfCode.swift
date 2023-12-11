import Foundation
import ArgumentParser

@main
struct AdventOfCode: ParsableCommand {

  private static let days: [ParsableCommand.Type] = [
    Day1.self,
    Day2.self,
    Day3.self,
    Day4.self,
    Day6.self,
    Day11.self
  ]

  static let configuration = CommandConfiguration(
    abstract: "Solutions to Advent of Code 2023 🎄",
    subcommands: days,
    helpNames: .shortAndLong
  )
}
