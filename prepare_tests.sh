#!/usr/bin/env bash

pwd

echo "Install bundle"
bundle install
bundle exec pod repo update
bundle exec pod install
