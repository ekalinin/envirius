#!/usr/bin/env bats

load test_helper

@test "plugin: erlang" {
    run nv mk erlang_test_env --erlang=17.0-rc1
    assert_success

    nv on --same-shell erlang_test_env

    # http://stackoverflow.com/a/9561362
    run erl -noshell -eval \
        'io:fwrite("~s\n", [erlang:system_info(otp_release)]).' \
        -s erlang halt
    assert_success
    assert_output '17'
}

@test "plugin: erlang with rebar" {
    run nv mk erlang_test_env --erlang=17.0-rc1
    assert_success

    nv on --same-shell erlang_test_env

    run rebar --version
    assert_success

    [ `echo "${lines[0]}" | grep rebar | grep git` ]
    [ "${lines[1]}" = "" ]
}
