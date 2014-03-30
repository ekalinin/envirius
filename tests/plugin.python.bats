#!/usr/bin/env bats

load test_helper

@test "plugin: python" {
    run nv mk python_test_env --python=3.4.0
    assert_success

    nv on python_test_env

    run python3.4 -V
    assert_success
    assert_output "Python 3.4.0"
}

@test "plugin: check pip & python simlink" {
    run nv mk python_test_env --python=3.3.5
    assert_success

    [ -f "$NV_HOME/envs/python_test_env/bin/pip" ]
    [ -f "$NV_HOME/envs/python_test_env/bin/python" ]
}
