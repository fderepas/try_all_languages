

## Services to run docker images for all languages

## What this directory contains

This directory enables to build a REST API to access the containers executing the arbitrary programs.

## rest_api_server

Launches a pm2 webserver reading the REST requests. 

## rest_api_server_test

Tests the REST API of each language using random tests.

## rest_api_docker

Creates a container containing a rest_api_server system.

