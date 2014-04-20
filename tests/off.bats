#!/usr/bin/env bats

load test_helper

@test "off: mk empty env & activate/deactivate it" {
    run nv mk empty_env2
    assert_success
    [ "${lines[0]}"  = "Creating environment: empty_env2 ..." ]

    run nv ls
    assert_success
    [ "${lines[0]}"  = "Available environment(s):" ]
    [ "${lines[1]}"  = "empty_env2" ]

    nv on --same-shell test_empty_env2
    assert_equal "test_empty_env2" "$NV_USED_ENV"

    nv off
    [ "`echo $NV_USED_ENV`" = "" ]
    [ "`echo $NV_OLD_PATH`" = "" ]
}

@test "off: with prompt-enable" {
    run nv mk empty_env2
    assert_success

    nv on --same-shell test_empty_env2 --prompt-enable
    assert_equal "test_empty_env2" "$NV_USED_ENV"

    nv off
    assert_equal "" `echo "$PS1" | grep "(test_empty_env1)"`
    assert_equal "" "$NV_OLD_PS1"
}

@test "deactivate: mk empty env & activate/deactivate it" {
    run nv mk empty_env2
    assert_success
    [ "${lines[0]}"  = "Creating environment: empty_env2 ..." ]

    run nv ls
    assert_success
    [ "${lines[0]}"  = "Available environment(s):" ]
    [ "${lines[1]}"  = "empty_env2" ]

    nv on --same-shell test_empty_env2
    [ "`echo $NV_USED_ENV`" = "test_empty_env2" ]

    nv deactivate
    [ "`echo $NV_USED_ENV`" = "" ]
    [ "`echo $NV_OLD_PATH`" = "" ]
}

@test "deactivate: with prompt-enable" {
    run nv mk empty_env2
    assert_success

    nv on --same-shell test_empty_env2 --prompt-enable
    assert_equal "test_empty_env2" "$NV_USED_ENV"

    nv deactivate
    assert_equal "" `echo "$PS1" | grep "(test_empty_env1)"`
    assert_equal "" "$NV_OLD_PS1"
}
