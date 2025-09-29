//
//  ConverterTable.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 30.09.2025.
//

struct ConverterTable {
    private static let characterTranslationTable: [Character: String] = [
           "A": "aa",
           "B": "bb",
           "C": "cc",
           "D": "dd",
           "E": "ee",
           "F": "ff",
           "G": "gg",
           "H": "hh",
           "I": "ii",
           "J": "jj",
           "K": "kk",
           "L": "ll",
           "M": "mm",
           "N": "nn",
           "O": "oo",
           "P": "pp",
           "Q": "qq",
           "R": "rr",
           "S": "ss",
           "T": "tt",
           "U": "uu",
           "V": "vv",
           "W": "ww",
           "X": "xx",
           "Y": "yy",
           "Z": "zz",
           
           ",": "comma",
           "!": "exclamationMark",
           " ": "space",
           ".": "period",
           ":": "collon",
           ")": "closeBrackets",
           "(": "openBrackets",
           "?": "questionMark",
           "@": "at",
           "'": "singleQuote",
           "-": "hyphen",
           "_": "underscore",
           "=": "equals"
       ]
    
    static func exchangeCharacter(_ char: Character) -> String {
        ConverterTable.characterTranslationTable[char] ?? String(char)
    }
}
