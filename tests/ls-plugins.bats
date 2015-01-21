#!/usr/bin/env bats

load test_helper

@test "ls-plugins: list enabled plugins" {
    run nv ls-plugins
    [ "$status" -eq 0 ]
    assert_success
    assert_equal "elixir"           "${lines[0]}"
    assert_equal "elixir-prebuilt"  "${lines[1]}"
    assert_equal "erlang"           "${lines[2]}"
    assert_equal "go-prebuilt"      "${lines[3]}"
    assert_equal "haskell"          "${lines[4]}"
    assert_equal "haskell-platform" "${lines[5]}"
    assert_equal "haskell-prebuilt" "${lines[6]}"
    assert_equal "iojs"             "${lines[7]}"
    assert_equal "iojs-prebuilt"    "${lines[8]}"
    assert_equal "julia"            "${lines[9]}"
    assert_equal "node"             "${lines[10]}"
    assert_equal "node-prebuilt"    "${lines[11]}"
    assert_equal "php"              "${lines[12]}"
    assert_equal "python"           "${lines[13]}"
    assert_equal "rust"             "${lines[14]}"
    assert_equal "rust-prebuilt"    "${lines[15]}"
    assert_equal "scala"            "${lines[16]}"
    assert_equal ""                 "${lines[17]}"
}
