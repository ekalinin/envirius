#!/usr/bin/env bats

load test_helper

@test "version" {
    run mem version
    [ "$output" = "mem 0.1.0" ]
}
