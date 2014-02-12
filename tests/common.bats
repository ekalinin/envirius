#!/usr/bin/env bats

load test_helper

@test "common: get_plugin_name" {
    run get_plugin_name "--rust=0.9"
    assert_success
    assert_output "rust"

    run get_plugin_name "--go=1.2rc4"
    assert_success
    assert_output "go"

    run get_plugin_name "--erlang=17.0-rc1"
    assert_success
    assert_output "erlang"
}
