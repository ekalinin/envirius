#!/usr/bin/env bats

load test_helper

@test "versions: for go" {
    line_0=$(bold "* go:";)
    run mem versions --go
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = $line_0 ]
    [ "${lines[1]}" = "1.0.1       1.0.2       1.0.3       1.1.1       1.1.2       " ]
    [ "${lines[2]}" = "1.1rc1      1.1rc2      1.1rc3      1.2rc1      1.2rc2      " ]
    [ "${lines[3]}" = "1.2rc3      1.2rc4      1.2rc5      " ]
}
