#!/usr/bin/env bats

load test_helper

@test "versions: for disabled plugin [go]" {
    line_0=$(bold "* go:";)
    run nv versions --go
    assert_success
    assert_equal "${lines[0]}" $line_0
    assert_equal "${lines[1]}" " - plugin disabled."
}

@test "versions: for enabled plugin [rust]" {
    line_0=$(bold "* rust:";)
    run nv versions --rust
    assert_success

    assert_equal "${lines[0]}" $line_0
    assert_equal "${lines[1]}" "0.1         0.2         0.3         0.4         0.5         "
    assert_equal "${lines[2]}" "0.6         0.7         0.8         0.9         "
}
