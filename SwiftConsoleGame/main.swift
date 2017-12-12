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
    
    // Working...I think?
    func loadCommandsFromFile(fileName: String) -> Array<String> {
        let nullText: Array<String> = Array<String>();
        do {
            let file = try String(contentsOfFile: fileName)
            let text: [String] = file.components(separatedBy: "\n")
            return text;
        } catch {
            Swift.print("Fatal Error: Couldn't read the contents!")
        }
        
        return nullText;
    }
    
    //Structure is <Command>:<Result>
    mutating func registerCommandsFromArray(_ commandsArray: Array<String>){
        for command in commandsArray
        {
            if (command != "")
            {
                var com: Array<String> = command.components(separatedBy: ":");
                registerCommand(Command(com[0], com[1]));
            }
        }
    }
}

class Game {
    private(set) var isRunning: Bool;
    var commandRegister: CommandRegister;
    
    init()
    {
        isRunning = false;
        commandRegister = CommandRegister();
    }
    
    func InitCommands(){
        commandRegister.registerCommand(Command("hi", "Hello There!"));
        commandRegister.registerCommand(Command("how are you?", "I'm fine thanks for asking"));
        commandRegister.registerCommand(Command("what is your name?", "I'm a DI"));
        commandRegister.registerCommand(Command("what is a DI?", "A dumb pre-programmed intelligence"));
        
        let com: Array<String>? = self.commandRegister.loadCommandsFromFile(fileName: "/usr/share/man/man1/commands.txt");
        self.commandRegister.registerCommandsFromArray(com!);
    }
    
    func start() {
        InitCommands();
        
        isRunning = true;
        while (isRunning)
        {
            var command = readLine();
            command = command?.localizedLowercase;
            var pros: Bool = false;
            for element:Command in commandRegister.commands
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
