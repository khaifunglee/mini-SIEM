# This script simulates a simple app generating events

LOGFILE="$HOME/mini-SIEM/test-app/logs/app.log" # edit your path to the repo here
# Array of log levels
LEVELS=("INFO" "WARN" "ERROR" "DEBUG")
# Array of messages
MESSAGES=(
    "Login successful"
    "Database connection established"
    "Login failed"
    "Invalid credentials"
    "Session expired"
    "API request timeout"
    "Payment processed"
    "Configuration loaded"
    "Cache miss"
)

# Generate logs continuously
while true; do
    # Choose a random log level and message
    LEVEL=${LEVELS[$RANDOM % ${#LEVELS[@]}]}
    MESSAGE=${MESSAGES[$RANDOM % ${#MESSAGES[@]}]}

    # Current timestamp
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

    LOG="[$TIMESTAMP] [$LEVEL] $MESSAGE"

    echo $LOG >> $LOGFILE

    # Wait 2-5 seconds between sending each log
    sleep $((2 + RANDOM % 4))
done