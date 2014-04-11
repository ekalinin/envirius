#!/usr/bin/env bats

load test_helper

@test "do: simple check" {
    nv mk node_test_env --node=0.10.26
    number_of_packages=$(nv do node_test_env 'npm -g ls' | wc -l)
    [ "$number_of_packages" = "84" ]
}

@test "do: environment does not exist" {
    run nv do node_test_env 'npm -g ls'
    assert_success
    assert_output "Environment does not exist (node_test_env)."
}
