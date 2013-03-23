#!/usr/bin/env bash

#DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer

echo "Run xbuild"

xcodebuild -scheme LogicTests -workspace Brandymint.xcworkspace -sdk iphonesimulator6.1 -configuration Debug TEST_AFTER_BUILD=YES TEST_HOST= ONLY_ACTIVE_ARCH=NO clean build

#xcodebuild -target LogicTests -sdk iphonesimulator6.1 -configuration Debug TEST_AFTER_BUILD=YES clean build 2>&1 | bundle exec ocunit2junit


# xcodebuild -workspace Brandymint.xcworkspace -scheme BrandymintTests -sdk iphonesimulator6.1  -configuration Debug TEST_AFTER_BUILD=YES clean build


# TEST_AFTER_BUILD=YES

# Так пускает jenkins
# xcodebuild -alltargets
# -sdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.1.sdk
# -configuration Release clean build


# Reads
# http://9elements.com/io/index.php/continuous-integration-of-ios-projects-using-jenkins-cocoapods-and-kiwi/
# http://www.raingrove.com/2012/03/28/running-ocunit-and-specta-tests-from-command-line.html

# brew install ios-sim
# RUN_APPLICATION_TESTS_WITH_IOS_SIM=YES 

# Launch application using ios-sim and set up environment to inject test bundle into application
# Source: http://stackoverflow.com/a/12682617/504494
 
#if [ "$RUN_APPLICATION_TESTS_WITH_IOS_SIM" = "YES" ]; then
    #test_bundle_path="$BUILT_PRODUCTS_DIR/$PRODUCT_NAME.$WRAPPER_EXTENSION"
    #environment_args="--setenv DYLD_INSERT_LIBRARIES=/../../Library/PrivateFrameworks/IDEBundleInjection.framework/IDEBundleInjection --setenv XCInjectBundle=$test_bundle_path --setenv XCInjectBundleInto=$TEST_HOST"
    #ios-sim launch $(dirname $TEST_HOST) $environment_args --args -SenTest All $test_bundle_path
    #echo "Finished running tests with ios-sim"
#else
    #"${SYSTEM_DEVELOPER_DIR}/Tools/RunUnitTests"
#fi
