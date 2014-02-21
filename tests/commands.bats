#!/usr/bin/env bats

load test_helper

@test "commands: list commands" {
    run nv commands
    assert_success

    [ "${lines[0]}"  = "  activate        Activate environment (alias: on)" ]
    [ "${lines[1]}"  = "  autoon          Mark current directory for environment auto activating" ]
    [ "${lines[2]}"  = "  commands        List available commands" ]
    [ "${lines[3]}"  = "  cp              Copy environment" ]
    [ "${lines[4]}"  = "  current         Output current environment's name" ]
    [ "${lines[5]}"  = "  deactivate      Deactivate environment (alias: off)" ]
    [ "${lines[6]}"  = "  ls              List environments" ]
    [ "${lines[7]}"  = "  mk              Create environment" ]
    [ "${lines[8]}"  = "  mv              Move (rename) environment" ]
    [ "${lines[9]}"  = "  off             Deactivate environment (alias: deactivate)" ]
    [ "${lines[10]}" = "  on              Activate environment (alias: activate)" ]
    [ "${lines[11]}" = "  plugins         List available plugins" ]
    [ "${lines[12]}" = "  rm              Delete environment" ]
    [ "${lines[13]}" = "  version         Display the version number" ]
    [ "${lines[14]}" = "  versions        Lists available versions for plugins" ]
}
