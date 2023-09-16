FROM docker.io/nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04 AS base

RUN apt-get update && apt-get install -y \
  mesa-utils \
  mesa-utils-extra \
  glmark2 \