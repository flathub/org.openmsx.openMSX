#!/usr/bin/env bash

clear
flatpak-builder --repo=testing-repo --force-clean build-dir org.openmsx.openMSX.yaml
flatpak --user remote-add --if-not-exists --no-gpg-verify msx-testing-repo testing-repo
flatpak --user install msx-testing-repo org.openmsx.openMSX -y
flatpak --user install msx-testing-repo org.openmsx.openMSX.Debug -y
flatpak update -y
