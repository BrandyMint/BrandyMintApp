git submodule init
git submodule update

ln -s ../tools/lcov XcodeCoverage/lcov-1.10

./prepare_tests.sh
./run_tests.sh
# sloccount --duplicates --wide --details . > ./sloccount.sc
#./publish_gcov.sh
