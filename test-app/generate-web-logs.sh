#!/bin/bash
# This script simulates a web page generating access logs

LOGFILE="$HOME/mini-SIEM/test-app/logs/web-access.log" # edit your path to the repo here
# Array of user agents
USER_AGENTS=(
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
            "curl/7.68.0"
            "python-requests/2.25.1"
            "Nmap Scripting Engine"
            )
# Array of paths (some suspicious)
PATHS=(
    "/index.html"
    "/about.html"
    "/api/users"
    "/login"
    "/admin/login"
    "/admin/config"
    "/.env"
    "/wp-admin"
    "/../../../etc/passwords"
    "/api/upload"
)

# Array of IP addresses
IPS=(
    "192.168.1.100" # Internal
    "10.0.0.25"     # Internal
    "203.0.113.45"  # External
    "198.51.100.23" # External
)

# Response codes
CODES=(200 200 200 200 404 403 401 500)

# Generate access events continuously
while true; do
  # Get random elements
  USER_AGENT=${USER_AGENTS[$RANDOM % ${#USER_AGENTS[@]}]}
  IP=${IPS[$RANDOM % ${#IPS[@]}]}
  PATH=${PATHS[$RANDOM % ${#PATHS[@]}]}
  CODE=${CODES[$RANDOM % ${#CODES[@]}]}
  
  # Generate timestamp using full path (just date not working for some reason)
  BYTES=$((100 + RANDOM % 9900))
  TIMESTAMP=$(/bin/date "+%d/%b/%Y:%H:%M:%S %z")
  
  # Write log
  LOG="$IP -- [$TIMESTAMP] \"GET $PATH HTTP/1.1\" $CODE $BYTES - \"$USER_AGENT\""

  echo "$LOG" >> "$LOGFILE"
  
  # Sleep using full path
  /bin/sleep $((3 + RANDOM % 5))
done
