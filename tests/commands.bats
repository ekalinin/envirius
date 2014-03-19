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
    [ "${lines[6]}"  = "  ls-envs         List environments" ]
    [ "${lines[7]}"  = "  ls-versions     Lists available versions for plugins" ]
    [ "${lines[8]}"  = "  mk              Create environment" ]
    [ "${lines[9]}"  = "  mv              Move (rename) environment" ]
    [ "${lines[10]}" = "  off             Deactivate environment (alias: deactivate)" ]
    [ "${lines[11]}" = "  on              Activate environment (alias: activate)" ]
    [ "${lines[12]}" = "  plugins         List available plugins" ]
    [ "${lines[13]}" = "  rm              Delete environment" ]
    [ "${lines[14]}" = "  version         Display the version number" ]
}
