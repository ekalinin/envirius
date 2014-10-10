#!/usr/bin/env bats

load test_helper

@test "ls-versions: for disabled plugin [stub]" {
    line_0=$(nv_bold "* stub:";)
    run nv ls-versions --stub
    assert_success
    assert_equal "${lines[0]}" $line_0
    assert_equal "${lines[1]}" " - plugin disabled."
}

@test "ls-versions: for enabled plugin [rust]" {
    line_0=$(nv_bold "* rust:";)
    run nv ls-versions --rust
    assert_success

    assert_equal "${lines[0]}" $line_0
    assert_equal "${lines[1]}" "0.1         0.2         0.3         0.3.1       0.4         "
    assert_equal "${lines[2]}" "0.5         0.6         0.7         0.8         0.9         "
}
