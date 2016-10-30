#!/usr/bin/env bats

load test_helper

@test "version: output version" {
    run nv version
    assert_success
    assert_output "nv 0.8.3"
}
