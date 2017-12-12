//
//  main.swift
//  SwiftConsoleGame
//
//  Created by Ruben Bezuidenhout on 2017/12/12.
//  Copyright © 2017 Ruben Bezuidenhout. All rights reserved.
//

import Foundation

class Command {
    let command: String?;
    let result: String?;
    
    init(_ command: String, _ result: String) {
        self.command = command;
        self.result = result;
    }
}

struct CommandRegister {
    var commands : Array<Command> = Array();
    
    mutating func registerCommand(_ command: Command){
        self.commands.append(command)
    }
    
    // Not woking ATM...
    func loadCommandsFromFile(fileName: String) -> [String]? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
            return nil
        }
        
        do {
            let content = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
            return content.components(separatedBy: "\n")
        } catch {
            return nil
        }
    }
}

class Game {
    private(set) var isRunning: Bool;
    var commandRegister: CommandRegister?;
    
    init() {
        isRunning = false;
        commandRegister = CommandRegister();
    }
    
    func InitCommands(){
        commandRegister!.registerCommand(Command("hi", "Hello There!"));
        commandRegister!.registerCommand(Command("how are you?", "I'm fine thanks for asking"));
        commandRegister!.registerCommand(Command("what is your name?", "I'm a DI"));
        commandRegister!.registerCommand(Command("what is a DI?", "A dumb pre-programmed intelligence"));
    }
    
    func start() {
        InitCommands();
        
        isRunning = true;
        while (isRunning)
        {
            var command = readLine();
            command = command?.localizedLowercase;
            var pros: Bool = false;
            for element:Command in commandRegister!.commands
            {
                if (element.command! == command)
                {
                    print(element.result!);
                    pros = true;
                    break;
                }
            }
            
            if (!pros)
            {
                print("I'm to dumb for that...")
            }
        }
    }
}

let game = Game();
game.start();
