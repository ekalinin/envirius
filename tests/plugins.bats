#!/usr/bin/env bats

load test_helper

@test "plugins: list enabled plugins" {
    run mem plugins
    [ "$status" -eq 0 ]
    assert_success
    assert_equal "${lines[0]}" "erlang"
    assert_equal "${lines[1]}" "rust"
    assert_equal "${lines[2]}" ""
}
