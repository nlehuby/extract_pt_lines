#!/bin/bash

set -ev

wget http://download.geofabrik.de/europe/france-latest.osm.pbf --no-verbose --output-document=data.osm.pbf 2>&1
#wget http://download.geofabrik.de/europe/monaco-latest.osm.pbf --no-verbose --output-document=data.osm.pbf 2>&1

osm_transit_extractor -i data.osm.pbf

mkdir output

cat osm-transit-extractor_lines.csv|xsv select 1-8 |xsv search -s shape '^$' -v > output/lines_from_osm.csv
