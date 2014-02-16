#!/usr/bin/env bats

load test_helper

@test "plugin: rust" {
    run nv mk rust_test_env --rust=0.9
    assert_success

    nv on rust_test_env

    run rustc -v
    assert_success
    assert_equal "${lines[0]}" "rustc 0.9"
}
