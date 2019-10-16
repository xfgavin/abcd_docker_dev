#!/usr/bin/env bash
rm -f mmps_engine.lrz*
lrzip -z -L 9 mmps_engine
split -b 100M -d mmps_engine.lrz mmps_engine.lrz
mv mmps_engine.lrz[01]* ../abcd_docker_mmps/mmps_engine/
