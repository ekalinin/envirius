#!/usr/bin/env bats

load test_helper

@test "version: output version" {
    run nv version
    [ "$status" -eq 0 ]
    [ "$output" = "nv 0.1.0" ]
}
