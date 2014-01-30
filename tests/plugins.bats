#!/usr/bin/env bats

load test_helper

@test "plugins" {
    run mem plugins
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "erlang" ]
    [ "${lines[1]}" = "go" ]
    [ "${lines[2]}" = "node" ]
    [ "${lines[3]}" = "python" ]
    [ "${lines[4]}" = "rust" ]
}
