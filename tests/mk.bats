#!/usr/bin/env bats

load test_helper

@test "mk: empty environment" {
    run nv mk test_env1 --no-meta
    assert_success

    run nv ls
    assert_success
    [ "${lines[0]}"  = "Available environment(s):" ]
    [ "${lines[1]}"  = "test_env1" ]
}

@test "mk: with disabled plugin" {
    run nv mk test_env --stub=3.2 --no-meta
    assert_success
    assert_equal "Creating environment: test_env ..." "${lines[0]}"
    assert_equal " * installing stub==3.2 ..." "${lines[1]}"
    assert_equal " - plugin disabled." "${lines[2]}"

    run nv ls
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "test_env" "${lines[1]}"
}

@test "mk: with name" {
    run nv mk test_env --rust-prebuilt=0.12.0 --no-meta
    #assert_success
    assert_equal "${lines[0]}"  "Creating environment: test_env ..."
    assert_equal "${lines[1]}"  " * installing rust-prebuilt==0.12.0 ..."

    run nv ls
    #assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "test_env" "${lines[1]}"
}

@test "mk: without name" {
    run nv mk --no-meta --rust-prebuilt=0.12.0
    assert_success
    assert_equal "Creating environment: rust-prebuilt-0.12.0 ..." "${lines[0]}"
    assert_equal " * installing rust-prebuilt==0.12.0 ..." "${lines[1]}"

    run nv ls
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "rust-prebuilt-0.12.0" "${lines[1]}"
}

@test "mk: without name & without version" {
    run nv mk --rust-prebuilt
    assert_success
    [ "${lines[0]}"  = "Creating environment: rust-prebuilt- ..." ]
    [ "${lines[1]}"  = " * installing rust-prebuilt== ..." ]
    [ "${lines[2]}"  = " - please choose a version (eg. --rust-prebuilt=\$VERSION, see \`nv ls-versions --rust-prebuilt\`)." ]
}


@test "mk: without name & meta" {
    run nv mk --go-prebuilt=1.7.3 --rust-prebuilt=0.12.0
    assert_success
    assert_equal "Creating environment: go-prebuilt-1.7.3-rust-prebuilt-0.12.0 ..." "${lines[0]}"
    assert_equal " * installing go-prebuilt==1.7.3 ..." "${lines[1]}"
    assert_equal " * installing rust-prebuilt==0.12.0 ..." "${lines[3]}"

    run nv ls
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "go-prebuilt-1.7.3-rust-prebuilt-0.12.0 (go-prebuilt==1.7.3, rust-prebuilt==0.12.0)" "${lines[1]}"
}

@test "mk: with name & meta" {
    run nv mk test_env --go-prebuilt=1.7.3 --rust-prebuilt=0.12.0
    assert_success
    [ "${lines[0]}"  = "Creating environment: test_env ..." ]
    [ "${lines[1]}"  = " * installing go-prebuilt==1.7.3 ..." ]
    [ "${lines[3]}"  = " * installing rust-prebuilt==0.12.0 ..." ]

    run nv ls
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "test_env (go-prebuilt==1.7.3, rust-prebuilt==0.12.0)" "${lines[1]}"
}

@test "mk: with --on option" {
    run nv mk test_env
    assert_success

    [ "$NV_USED_ENV" = "" ]

    nv mk test_env1 --on --same-shell

    [ "$NV_USED_ENV" = "test_env1" ]
}

@test "mk: with --force option" {
    run nv mk test_env
    assert_success "Creating environment: test_env ..."

    run nv mk test_env
    assert_success
    assert_equal "Environment with name 'test_env' is already exists." "${lines[0]}"
    assert_equal "Please, choose another name and try again." "${lines[1]}"

    run nv mk test_env
    assert_success
    assert_equal "Environment with name 'test_env' is already exists." "${lines[0]}"
    assert_equal "Please, choose another name and try again." "${lines[1]}"

    run nv mk test_env --force
    assert_success
    assert_equal "Environment $(nv_bold 'test_env') was deleted." "${lines[0]}"
    assert_equal "Creating environment: test_env ..." "${lines[1]}"
}

@test "mk: with not supported plugin" {
    run nv mk test_env --not-supported
    assert_success
    assert_equal "Creating environment: test_env ..." "${lines[0]}"
    assert_equal " * installing not-supported== ..." "${lines[1]}"
    assert_equal " - plugin not exists: not-supported" "${lines[2]}"
}

@test "mk: without name totaly" {
    run nv mk
    assert_success
    assert_equal "Please, enter a name for a new environment." "${lines[0]}"
}
