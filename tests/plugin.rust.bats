#!/usr/bin/env bats

load test_helper

@test "plugin: rust" {
    run nv mk rust_test_env --rust=0.9
    assert_success

    nv on --same-shell rust_test_env

    run rustc -v
    assert_success
    assert_equal "rustc 0.9" "${lines[0]}"
}

@test "plugin: rust-prebuilt" {
    run nv mk rust_test_env --rust-prebuilt=0.10
    assert_success

    nv on --same-shell rust_test_env

    run rustc -v
    assert_success
    assert_equal "rustc 0.10 (46867cc 2014-04-02 16:59:39 -0700)" "${lines[0]}"
}
