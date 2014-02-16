#!/usr/bin/env bats

load test_helper

@test "plugins: list enabled plugins" {
    run nv plugins
    [ "$status" -eq 0 ]
    assert_success
    assert_equal "${lines[0]}" "elixir"
    assert_equal "${lines[1]}" "erlang"
    assert_equal "${lines[2]}" "rust"
    assert_equal "${lines[3]}" ""
}
