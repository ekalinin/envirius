#!/usr/bin/env bats

load test_helper

@test "rm: all" {
    run mem rm -all
    [ "$status" -eq 0 ]
    run mem ls
    [ "$status" -eq 0 ]
    [ "${lines[0]}"  = "Available environment(s):" ]
}
