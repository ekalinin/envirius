#!/usr/bin/env bats

load test_helper

@test "plugin: haskell" {
    run nv mk --haskell=7.8.1
    assert_success

    nv on --same-shell haskell-7.8.1

    run ghc --version
    assert_success "The Glorious Glasgow Haskell Compilation System, version 7.8.1"
}

@test "plugin: haskell-prebuilt" {
    run nv mk --haskell-prebuilt=7.8.2
    assert_success

    nv on --same-shell haskell-prebuilt-7.8.2

    run ghc --version
    assert_success "The Glorious Glasgow Haskell Compilation System, version 7.8.2"
}
