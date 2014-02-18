#!/usr/bin/env bats

load test_helper

@test "plugin: julia" {
    run nv mk test_env --julia=0.2.1
    assert_success

    nv on test_env

    run julia -v
    assert_success
    assert_output "julia version 0.2.1"
}
