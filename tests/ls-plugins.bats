#!/usr/bin/env bats

load test_helper

@test "ls-plugins: list enabled plugins" {
    run nv ls-plugins
    [ "$status" -eq 0 ]
    assert_success
    assert_equal "elixir" "${lines[0]}"
    assert_equal "erlang" "${lines[1]}"
    assert_equal "go"     "${lines[2]}"
    assert_equal "julia"  "${lines[3]}"
    assert_equal "node"   "${lines[4]}"
    assert_equal "rust"   "${lines[5]}"
    assert_equal ""       "${lines[6]}"
}
