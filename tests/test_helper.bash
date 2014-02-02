setup() {
    export MEM_PATH="$BATS_TEST_DIRNAME/../src"
    export MEM_HOME="$BATS_TEST_DIRNAME/tmp-mem-home"
    mkdir -p $MEM_HOME
    . $BATS_TEST_DIRNAME/../src/mem
}

assert_equal() {
  if [ "$1" != "$2" ]; then
    echo "expected: $1"
    echo "actual:   $2"
    return 1
  fi
}
