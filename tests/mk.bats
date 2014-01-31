#!/usr/bin/env bats

load test_helper

@test "mk: empty environment" {
    run mem rm test_env1
    [ "$status" -eq 0 ]
    run mem mk test_env1
    [ "$status" -eq 0 ]
    run mem ls
    [ "$status" -eq 0 ]
    [ "${lines[0]}"  = "Available environment(s):" ]
    [ "${lines[1]}"  = "test_env1" ]
}
