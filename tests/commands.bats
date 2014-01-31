#!/usr/bin/env bats

load test_helper

@test "commands: list commands" {
    run mem commands
    echo ${lines[0]}
    [ "${lines[0]}"  = "  activate        Activate environment (alias: on)" ]
    [ "${lines[1]}"  = "  autoon          Mark current directory for environment auto activating" ]
    [ "${lines[2]}"  = "  commands        List available commands" ]
    [ "${lines[3]}"  = "  current         Output current environment's name" ]
    [ "${lines[4]}"  = "  deactivate      Deactivate environment (alias: off)" ]
    [ "${lines[5]}"  = "  ls              List environments" ]
    [ "${lines[6]}"  = "  mk              Create environment" ]
    [ "${lines[7]}"  = "  off             Deactivate environment (alias: deactivate)" ]
    [ "${lines[8]}"  = "  on              Activate environment (alias: activate)" ]
    [ "${lines[9]}"  = "  plugins         List available plugins" ]
    [ "${lines[10]}" = "  rm              Delete environment" ]
    [ "${lines[11]}" = "  version         Display the version number" ]
    [ "${lines[12]}" = "  versions        Lists available versions for plugins" ]
}
