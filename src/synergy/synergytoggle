#!/usr/bin/env fish

# Check if synergy server is running using pgrep
if pgrep -x synergys
	# `set' will fail if pgrep does so if there is no running 
	# process the loop never executes
	while set synergyPIDs (pgrep -x synergys)
		kill $synergyPIDs
		sleep 1
	end
else
	synergys
end
