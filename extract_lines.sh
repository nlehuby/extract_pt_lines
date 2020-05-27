#!/bin/bash

set -ev

#wget http://download.geofabrik.de/europe/france-latest.osm.pbf --no-verbose --output-document=data.osm.pbf 2>&1
wget http://download.geofabrik.de/europe/monaco-latest.osm.pbf --no-verbose --output-document=data.osm.pbf 2>&1

osm_transit_extractor -i data.osm.pbf

mkdir output

cat osm-transit-extractor_lines.csv | xsv search -s shape '^$' -v > lines_with_shapes.csv

#ogr2ogr output/lines.geojson -dialect sqlite -sql "SELECT *, GeomFromText(shape) FROM lines_with_shapes" lines_with_shapes.csv -a_srs "WGS84"
ogr2ogr -f "ESRI Shapefile" output/lines_with_shape.shp -dialect sqlite -sql "SELECT *, GeomFromText(shape) FROM lines_with_shapes" lines_with_shapes.csv -a_srs "WGS84" -lco ENCODING=UTF-8


cat lines_with_shapes.csv |xsv select '!shape' > output/lines.csv
