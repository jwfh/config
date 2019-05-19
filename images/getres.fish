#!/usr/bin/env fish

if [ (math \((system_profiler SPDisplaysDataType | grep Resolution | head -n 1 | awk '{ print $2 }')/(system_profiler SPDisplaysDataType | grep Resolution | head -n 1 | awk '{ print $4 }')\)/\(16/10\)) = "1" ]
	echo "16:10"
else if [ (math \((system_profiler SPDisplaysDataType | grep Resolution | head -n 1 | awk '{ print $2 }')/(system_profiler SPDisplaysDataType | grep Resolution | head -n 1 | awk '{ print $4 }')\)/\(16/9\)) = "1" ]
	echo "16:9"
end
