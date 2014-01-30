setup() {
    export MEM_PATH="$BATS_TEST_DIRNAME/../src"
    export MEM_HOME="$BATS_TEST_DIRNAME/tmp-mem-home"
    mkdir -p $MEM_HOME
    . $BATS_TEST_DIRNAME/../src/mem
}
