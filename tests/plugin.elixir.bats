#!/usr/bin/env bats

load test_helper

@test "plugin: elixir" {
    run nv mk elixir_test_env --erlang=17.0-rc1 --elixir=0.12.4
    assert_success

    nv on --same-shell elixir_test_env

    run elixir -v
    assert_success
    assert_output "Elixir 0.12.4"
}

@test "plugin: elixir-prebuilt" {
    run nv mk elixir_test_env --erlang=17.0 --elixir-prebuilt=0.12.5
    assert_success

    nv on --same-shell elixir_test_env

    run elixir -v
    assert_success
    assert_output "Elixir 0.12.5"
}
