#!/bin/bash

dnf install -y yum-utils

yum-config-manager --add-repo \
https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

dnf install -y terraform git vim