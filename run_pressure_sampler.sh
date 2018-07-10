#!/bin/bash
gpspipe -R | gawk -f sample_gps_alt.awk
