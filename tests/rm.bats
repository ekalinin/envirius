#!/usr/bin/env bats

load test_helper

@test "rm: all" {
    run nv rm -all
    [ "$status" -eq 0 ]
    run nv ls-envs
    [ "$status" -eq 0 ]
    [ "${lines[0]}"  = "Available environment(s):" ]
}
