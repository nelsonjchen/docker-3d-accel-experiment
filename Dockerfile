FROM ubuntu:22.04 AS base

RUN apt-get update && apt-get install -y \
  mesa-utils \
  mesa-utils-extra \
  glmark2 \