#!/bin/bash

xcodebuild -workspace Brandymint.xcworkspace -scheme BrandymintTests -sdk iphonesimulator6.1  -configuration Debug clean build
