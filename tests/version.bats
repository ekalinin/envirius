#!/usr/bin/env bats

load test_helper

@test "version: output version" {
    run mem version
    [ "$status" -eq 0 ]
    [ "$output" = "mem 0.1.0" ]
}
