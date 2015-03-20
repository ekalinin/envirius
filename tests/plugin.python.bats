#!/usr/bin/env bats

load test_helper

@test "plugin: python 3.4.0 simple installation" {
    run nv mk python_test_env --python=3.4.0
    assert_success

    nv on --same-shell python_test_env

    run python3.4 -V
    assert_success
    assert_output "Python 3.4.0"
}

@test "plugin: python 3.3.5 + check pip & python simlink" {
    run nv mk python_test_env --python=3.3.5
    assert_success

    [ -f "$NV_HOME/envs/python_test_env/bin/pip" ]
    [ -f "$NV_HOME/envs/python_test_env/bin/python" ]

    nv on --same-shell python_test_env

    run python -V
    assert_success
    assert_output "Python 3.3.5"

    run pip -V
    assert_success
    assert_output "pip 6.0.8 from $NV_HOME/envs/python_test_env/lib/python3.3/site-packages (python 3.3)"
}
