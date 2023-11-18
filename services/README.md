

## Services to run docker images for all languages

## What this directory contains

This directory enables to build a REST API to access the containers executing the arbitrary programs.

## vmfrontend

Launches a pm2 webserver reading the REST requests. 

## vmfrontend_test

Tests the REST API of each language using random tests.

## allvms

Creates a container containing a vmfrontend system.

