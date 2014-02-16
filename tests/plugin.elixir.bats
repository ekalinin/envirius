#!/usr/bin/env bats

load test_helper

@test "plugin: elixir" {
    run nv mk elixir_test_env --erlang=17.0-rc1 --elixir=0.12.4
    assert_success

    nv on elixir_test_env

    run elixir -v
    assert_success
    assert_output "Elixir 0.12.4"
}
