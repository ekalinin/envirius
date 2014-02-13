#!/usr/bin/env bats

load test_helper

@test "plugin: rust" {
    run nv rm --all
    [ "$status" -eq 0 ]
    run nv mk rust_test_env --rust=0.9
    [ "$status" -eq 0 ]
    nv on rust_test_env
    [ "$status" -eq 0 ]
    run rustc -v
    [ "$status" -eq 0 ]
    assert_equal "${lines[0]}" "rustc 0.9"
}
