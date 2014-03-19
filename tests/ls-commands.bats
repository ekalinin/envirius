#!/usr/bin/env bats

load test_helper

@test "ls-commands: list commands" {
    run nv ls-commands
    assert_success

    assert_equal "  activate        Activate environment (alias: on)"                            "${lines[0]}" 
    assert_equal "  autoon          Mark current directory for environment auto activating"      "${lines[1]}" 
    assert_equal "  cp              Copy environment"                                            "${lines[2]}" 
    assert_equal "  current         Output current environment's name"                           "${lines[3]}" 
    assert_equal "  deactivate      Deactivate environment (alias: off)"                         "${lines[4]}" 
    assert_equal "  ls-commands     List available commands"                                     "${lines[5]}" 
    assert_equal "  ls-envs         List environments"                                           "${lines[6]}" 
    assert_equal "  ls-plugins      List available plugins"                                      "${lines[7]}" 
    assert_equal "  ls-versions     Lists available versions for plugins"                        "${lines[8]}" 
    assert_equal "  mk              Create environment"                                          "${lines[9]}" 
    assert_equal "  mv              Move (rename) environment"                                   "${lines[10]}"
    assert_equal "  off             Deactivate environment (alias: deactivate)"                  "${lines[11]}"
    assert_equal "  on              Activate environment (alias: activate)"                      "${lines[12]}"
    assert_equal "  rm              Delete environment"                                          "${lines[13]}"
    assert_equal "  version         Display the version number"                                  "${lines[14]}"
}
