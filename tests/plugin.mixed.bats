#!/usr/bin/env bats

load test_helper

@test "plugin: python + go" {
    run nv mk mixed_py_go --python=3.3.5 --go-prebuilt=1.2.1
    assert_success

    nv on --same-shell mixed_py_go

    run python -V
    assert_success
    assert_output "Python 3.3.5"

    run pip -V
    assert_success
    assert_output "pip 6.0.8 from $NV_HOME/envs/mixed_py_go/lib/python3.3/site-packages (python 3.3)"

    run go version
    assert_success
    assert_output "go version go1.2.1 linux/386"
}

@test "plugin: go + python" {
    run nv mk mixed_py_go --go-prebuilt=1.2.1 --python=3.3.5 
    assert_success

    nv on --same-shell mixed_py_go

    run python -V
    assert_success
    assert_output "Python 3.3.5"

    run pip -V
    assert_success
    assert_output "pip 6.0.8 from $NV_HOME/envs/mixed_py_go/lib/python3.3/site-packages (python 3.3)"

    run go version
    assert_success
    assert_output "go version go1.2.1 linux/386"
}
