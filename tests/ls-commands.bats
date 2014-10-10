#!/usr/bin/env bats

load test_helper

@test "ls-commands: list commands" {
    run nv ls-commands
    assert_success
    local pos=0

    assert_equal "  activate        Activate environment (aliases: on, use)"                    "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  autoon          Mark current directory for environment auto activating"     "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  cp              Copy environment"                                           "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  current         Output current environment's name"                          "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  deactivate      Deactivate environment (alias: off)"                        "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  do              Execute something inside environment"                       "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  export          Export environment into tar archive"                        "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  import          Import archive as environment"                              "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  ls              List environments"                                          "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  ls-cache        List locally cached verions (no need to download & build)"  "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  ls-commands     List available commands"                                    "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  ls-plugins      List available plugins"                                     "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  ls-versions     Lists available versions for plugins"                       "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  mk              Create environment"                                         "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  mv              Move (rename) environment"                                  "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  off             Deactivate environment (alias: deactivate)"                 "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  on              Activate environment (aliases: activate, use)"              "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  rm              Delete environment"                                         "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  rm-cache        Delete cache entry"                                         "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  use             Activate environment (aliases: activate, on)"               "${lines[$pos]}"; pos=$((pos+1));
    assert_equal "  version         Display the version number"                                 "${lines[$pos]}"; pos=$((pos+1));
}
