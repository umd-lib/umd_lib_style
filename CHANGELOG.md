# Changelog

## Introduction

This document records notable changes to the functionality of this gem.

Note: Only changes that affect behavior need to be recorded.

## 3.0.0

* Support Rails 6.1 and webpacker.

## 2.0.0

* API-breaking change to the behavior of the environment banner. The
  environment banner no longer uses the hostname in setting the banner,
  instead relying on environment variables for configuring the banner
  on non-development system. See the README.md for more details.

  For local development, a "Local Environment" banner is displayed by default.

## 1.2.0

* Additional directives can now be added to HTML "head" section.

## 1.1.0

* Implemented "sticky footer"

## 1.0.1

* No functionality changes.

## 1.0.0

* Initial implementation
