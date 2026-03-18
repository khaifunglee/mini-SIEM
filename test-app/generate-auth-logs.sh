# This script simulates a simple app generating authentication events

LOGFILE="$HOME/khaifungfreeman@gmail.com - Google Drive/My Drive/Projects/Cybersecurity/SIEM-project/test-app/logs/auth.log"
# Array of usernames
USERS=("admin" "root" "jack" "postgres" "backup" "external user")
# Array of IP addresses
IPS=(
    "192.168.1.100" # Internal
    "192.168.1.105" # Internal
    "10.0.0.50"     # Internal
    "203.0.113.45"  # External
    "198.51.100.23" # External
    "185.220.101.5" # Suspicious
)

# Categorize authentication events
EVENTS=("Accepted" "Failed")

# Generate auth events continuously
while true; do
    # Choose a random user, IP, auth event
    USER=${USERS[$RANDOM % ${#USERS[@]}]}
    IP=${IPS[$RANDOM % ${#IPS[@]}]}
    EVENT=${EVENTS[$RANDOM % ${#EVENTS[@]}]}

    # Generate a random port number and timestamp
    PORT=$((1024 + RANDOM % 64512))
    TIMESTAMP=$(date "+%b %d %H:%M:%S")

    # Generate log based on auth level (generate random process ID for sshd message)
    if [ "$EVENT" = "Accepted" ]; then
        LOG="$TIMESTAMP siem-host sshd[$((RANDOM % 10000))]: $EVENT password for $USER from $IP port $PORT ssh2"
    else
        LOG="$TIMESTAMP siem-host sshd[$((RANDOM % 10000))]: $EVENT password for invalid user $USER from $IP port $PORT ssh2"
    fi 

    echo $LOG >> $LOGFILE

    # Wait 2-5 seconds between sending each log
    sleep $((2 + RANDOM % 6))
done