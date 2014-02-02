#!/usr/bin/env bats

load test_helper

@test "common: get_plugin_name" {
    run get_plugin_name "--rust=0.9"
    [ "$status" -eq 0 ]
    assert_equal "$output" "rust"

    run get_plugin_name "--go=1.2rc4"
    [ "$status" -eq 0 ]
    assert_equal "$output" "go"

    run get_plugin_name "--erlang=17.0-rc1"
    [ "$status" -eq 0 ]
    assert_equal "$output" "erlang"
}
