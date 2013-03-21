#!/usr/bin/env ruby
# https://github.com/brynbellomy/xcode-unit-testing-cli
require 'rubygems'
require 'xcodebuild'

XcodeBuild::Tasks::BuildTask.new do |t|
  # t.formatter = XcodeBuild::Formatters::ProgressFormatter.new
  t.sdk = "iphonesimulator6.1"
  t.target = "LogicTests"
  t.configuration = "Debug"
  #t.scheme = "YOUR TESTING SCHEME NAME"
  t.add_build_setting("TEST_AFTER_BUILD", "YES")
  t.add_build_setting("TEST_HOST", "")
end
