#!/usr/bin/env bats

load test_helper

@test "on: mk empty env & activate it" {
    run nv mk empty_env2
    assert_success
    [ "${lines[0]}"  = "Creating environment: empty_env2 ..." ]

    run nv ls
    assert_success
    [ "${lines[0]}"  = "Available environment(s):" ]
    [ "${lines[1]}"  = "empty_env2" ]

    nv on test_empty_env2
    assert_equal "test_empty_env2" "$NV_USED_ENV"
    [ "`echo $NV_OLD_PATH`" != "" ]
}

@test "on: empty env name" {
    run nv on
    assert_fail "Please, specify the name of the environment that will be activated."
}

@test "on: off previusly activated environment" {
    run nv mk empty_env1
    assert_success
    run nv mk empty_env2
    assert_success

    nv on test_empty_env1
    run nv current
    assert_success "test_empty_env1"

    nv on test_empty_env2
    run nv current
    assert_success "test_empty_env2"
}

@test "on: with prompt-enable" {
    run nv mk empty_env1
    assert_success

    nv on test_empty_env1 --prompt-enable
    [ `echo "$PS1" | grep "(test_empty_env1)"` ]
}

@test "on: with prompt-disable" {
    run nv mk empty_env1
    assert_success

    nv on test_empty_env1 --prompt-disable
    assert_equal "" `echo "$PS1" | grep "(test_empty_env1)"`
    assert_equal "" "$NV_OLD_PS1"
}

@test "on: don't create any envs" {
    run nv ls
    assert_success
    [ "${lines[1]}"  = "" ]

    run nv on --helpp
    assert_fail

    run nv ls
    assert_success
    assert_equal "" "${lines[1]}"
}

@test "activate: mk empty env & activate it" {
    # same as in test for 'on' command
    run nv mk empty_env2
    [ "$status" -eq 0 ]
    [ "${lines[0]}"  = "Creating environment: empty_env2 ..." ]
    run nv ls
    [ "$status" -eq 0 ]
    [ "${lines[0]}"  = "Available environment(s):" ]
    [ "${lines[1]}"  = "empty_env2" ]
    # end of copy from test for 'on' command
    nv activate test_empty_env2
    [ "$status" -eq 0 ]
    [ "`echo $NV_USED_ENV`" = "test_empty_env2" ]
    [ "`echo $NV_OLD_PATH`" != "" ]
}

@test "activate: empty env name" {
    run nv activate
    assert_fail
}

@test "activate: off previusly activated environment" {
    run nv mk empty_env1
    assert_success
    run nv mk empty_env2
    assert_success

    nv activate test_empty_env1
    run nv current
    assert_success "test_empty_env1"

    nv activate test_empty_env2
    run nv current
    assert_success "test_empty_env2"
}

@test "activate: with prompt-enable" {
    run nv mk empty_env1
    assert_success

    nv activate test_empty_env1 --prompt-enable
    [ `echo "$PS1" | grep "(test_empty_env1)"` ]
}

@test "activate: with prompt-disable" {
    run nv mk empty_env1
    assert_success

    nv activate test_empty_env1 --prompt-disable
    assert_equal "" `echo "$PS1" | grep "(test_empty_env1)"`
    assert_equal "" "$NV_OLD_PS1"
}

@test "activate: don't create any envs" {
    run nv ls
    assert_success
    [ "${lines[1]}"  = "" ]

    run nv activate --helpp
    assert_fail

    run nv ls
    assert_success
    assert_equal "" "${lines[1]}"
}
