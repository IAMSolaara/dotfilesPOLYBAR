ip route | grep '^default' | awk '{print $5}' | grep w
