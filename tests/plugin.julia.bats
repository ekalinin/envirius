#!/usr/bin/env bats

load test_helper

@test "plugin: julia" {
    run nv mk test_julia_env --julia=0.2.1
    assert_success

    nv on --same-shell test_julia_env

    run julia -v
    assert_success
    assert_output "julia version 0.2.1"
}
