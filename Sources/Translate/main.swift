// The Swift Programming Language
// https://docs.swift.org/swift-book

import TranslateCore
import Foundation
import CommandLineKit

let cli = CommandLineKit.CommandLine()
let sourceOption = StringOption(shortFlag: "s", longFlag: "source", helpMessage: "请输入你要翻译的内容")
cli.addOption(sourceOption)

let helpOption = BoolOption(shortFlag: "h", longFlag: "help",
                      helpMessage: "打印所有支持的指令")
cli.addOption(helpOption)

do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

let source = sourceOption.value ?? ""

if source.count > 0 {
    let semaphore = DispatchSemaphore(value: 0)
    let code = TranslateCode(parmas: [source])
    code.translate { string in
        print(string ?? "")
        semaphore.signal()
    }
    
    semaphore.wait()
}

if helpOption.value {
    cli.printUsage()
    exit(EX_OK)
}

if !cli.unparsedArguments.isEmpty {
    print("Unknow arguments: \(cli.unparsedArguments)")
    cli.printUsage()
    exit(EX_USAGE)
}

