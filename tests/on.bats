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

    nv on --same-shell test_empty_env2
    assert_equal "test_empty_env2" "$NV_USED_ENV"
    [ "`echo $NV_OLD_PATH`" != "" ]
}

@test "on: empty env name" {
    run nv on --same-shell
    assert_fail "Please, specify the name of the environment that will be activated."
    #assert_equal "Please, specify the name of the environment that will be activated." "${lines[0]}"
}

@test "on: off previously activated environment" {
    run nv mk empty_env1
    assert_success
    run nv mk empty_env2
    assert_success

    nv on --same-shell test_empty_env1
    run nv current
    assert_success "test_empty_env1"

    nv on --same-shell test_empty_env2
    run nv current
    assert_success "test_empty_env2"
}

@test "on: with prompt-enable" {
    run nv mk empty_env1
    assert_success

    nv on --same-shell test_empty_env1 --prompt-enable
    [ `echo "$PS1" | grep "(test_empty_env1)"` ]
}

@test "on: with prompt-disable" {
    run nv mk empty_env1
    assert_success

    nv on --same-shell test_empty_env1 --prompt-disable
    assert_equal "" `echo "$PS1" | grep "(test_empty_env1)"`
    assert_equal "" "$NV_OLD_PS1"
}

@test "on: wrong args don't create any envs" {
    run nv ls
    assert_success
    [ "${lines[1]}"  = "" ]

    run nv on --same-shell --helpp
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
    nv activate --same-shell test_empty_env2
    [ "$status" -eq 0 ]
    [ "`echo $NV_USED_ENV`" = "test_empty_env2" ]
    [ "`echo $NV_OLD_PATH`" != "" ]
}

@test "activate: empty env name" {
    run nv activate --same-shell
    assert_fail
}

@test "activate: off previously activated environment" {
    run nv mk empty_env1
    assert_success
    run nv mk empty_env2
    assert_success

    nv activate --same-shell test_empty_env1
    run nv current
    assert_success "test_empty_env1"

    nv activate --same-shell test_empty_env2
    run nv current
    assert_success "test_empty_env2"
}

@test "activate: with prompt-enable" {
    run nv mk empty_env1
    assert_success

    nv activate --same-shell test_empty_env1 --prompt-enable
    [ `echo "$PS1" | grep "(test_empty_env1)"` ]
}

@test "activate: with prompt-disable" {
    run nv mk empty_env1
    assert_success

    nv activate --same-shell test_empty_env1 --prompt-disable
    assert_equal "" `echo "$PS1" | grep "(test_empty_env1)"`
    assert_equal "" "$NV_OLD_PS1"
}

@test "activate: wrong args don't create any envs" {
    run nv ls
    assert_success
    [ "${lines[1]}"  = "" ]

    run nv activate --same-shell --helpp
    assert_fail

    run nv ls
    assert_success
    assert_equal "" "${lines[1]}"
}

@test "use: mk empty env & activate it" {
    # same as in test for 'on' command
    run nv mk empty_env2
    [ "$status" -eq 0 ]
    [ "${lines[0]}"  = "Creating environment: empty_env2 ..." ]
    run nv ls
    [ "$status" -eq 0 ]
    [ "${lines[0]}"  = "Available environment(s):" ]
    [ "${lines[1]}"  = "empty_env2" ]
    # end of copy from test for 'on' command
    nv use --same-shell test_empty_env2
    [ "$status" -eq 0 ]
    [ "`echo $NV_USED_ENV`" = "test_empty_env2" ]
    [ "`echo $NV_OLD_PATH`" != "" ]
}

@test "use: empty env name" {
    run nv use --same-shell
    assert_fail
}

@test "use: off previously activated environment" {
    run nv mk empty_env1
    assert_success
    run nv mk empty_env2
    assert_success

    nv use --same-shell test_empty_env1
    run nv current
    assert_success "test_empty_env1"

    nv use --same-shell test_empty_env2
    run nv current
    assert_success "test_empty_env2"
}

@test "use: with prompt-enable" {
    run nv mk empty_env1
    assert_success

    nv use --same-shell test_empty_env1 --prompt-enable
    [ `echo "$PS1" | grep "(test_empty_env1)"` ]
}

@test "use: with prompt-disable" {
    run nv mk empty_env1
    assert_success

    nv use --same-shell test_empty_env1 --prompt-disable
    assert_equal "" `echo "$PS1" | grep "(test_empty_env1)"`
    assert_equal "" "$NV_OLD_PS1"
}

@test "use: wrong args don't create any envs" {
    run nv ls
    assert_success
    [ "${lines[1]}"  = "" ]

    run nv use --same-shell --helpp
    assert_fail

    run nv ls
    assert_success
    assert_equal "" "${lines[1]}"
}
