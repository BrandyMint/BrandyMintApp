#!/usr/bin/env bash

echo "Publish coverage"

# Run gcov on the framework getting tested
#if [ "${CONFIGURATION}" = 'Coverage' ]; then
#	TARGET_NAME="LogicTests"
#	OBJ_DIR=${OBJROOT}/${TARGET_NAME}.build/${CONFIGURATION}/${TARGET_NAME}.build/Objects-normal/${CURRENT_ARCH}
#	mkdir -p Coverage
#	pushd Coverage
#	find "${OBJROOT}" -name *.gcda -exec gcov -o "${OBJ_DIR}" {} \; 2>/tmp/gconv-stderr | egrep "^File|^Lines" | sed -E "s@File #'$SRCROOT/@@;s@(\.[a-zA-Z])'@\1: @;s@Lines executed:([0-9.%]+) of ([0-9]+)@\1 (\2)@" | paste -d" " - - | egrep -v "^File '" | sed -E "s@^([^:]+):([^(]*)(\([^)]+\))@\2:\1\3@" | sort -n | sed -E "s@^([^:]+):([^(]*)(\([^)]+\))@\2:\1\3@"; cat /tmp/gconv-stderr | grep -v "version.*, prefer.*"; rm /tmp/gconv-stderr
#	popd
#fi

[ ! -d Coverage ] && mkdir Coverage

ROOT_DIR=`pwd`
OBJ_DIR=`echo $LINK_FILE_LIST_normal_i386 | sed -e 's/LogicTests.LinkFileList//'`

#echo "Root dir ${ROOT_DIR}"
#echo "Obj dir ${OBJ_DIR}"

xml="${ROOT_DIR}/Coverage/coverage.xml"

echo "Export GCOV coverage into ${xml}"

# /usr/local/share/python/gcovr
pushd ${OBJ_DIR}
/usr/local/share/python/gcovr -r $ROOT_DIR --xml > $xml
popd
