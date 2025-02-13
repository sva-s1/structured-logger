#!/usr/bin/env zsh

# Load environment variables from .env if present
if [[ -f .env ]]; then
  source .env
fi

# Default values if not set in .env
: "${COMMAND:=npm run dev}"
: "${LOGFILE_PATH:=log/dev.log}"

LOGFILE="$LOGFILE_PATH"

function on_exit() {
  echo "{ \"time\": \"$(date +'%Y-%m-%dT%H:%M:%S%z')\", \"event\": \"shutdown\" }" >> "$LOGFILE"
}

# Only log shutdown on SIGINT for demonstration
trap on_exit SIGINT

# Log startup
echo "{ \"time\": \"$(date +'%Y-%m-%dT%H:%M:%S%z')\", \"event\": \"startup\" }" >> "$LOGFILE"

# Run the chosen command in a pipeline
# e.g., npx docusaurus start, npm run dev, etc.
$COMMAND 2>&1 | while IFS= read -r line
do
  # Attempt to capture bracketed prefix, e.g. "[INFO] rest of line"
  # Regex explained:
  #   ^\[(.+)\]\s+(.*)
  #   ^\[         match literal '[' at start-of-line
  #   (.+)        capture all until the closing bracket as group #1
  #   \]\s+       match ']' plus some space(s)
  #   (.*)        capture the remainder as group #2

  if [[ "$line" =~ '^\[([A-Za-z0-9_-]+)\][[:space:]]+(.*)' ]]; then
    logLevel="${match[1]}"
    cleanMsg="${match[2]}"
  else
    logLevel="LOG"
    cleanMsg="$line"
  fi

  # Escape quotes in the message
  safeMsg=$(echo "$cleanMsg" | sed 's/"/\\"/g')

  # Print out our final structured JSON
  echo "{ \
    \"time\": \"$(date +'%Y-%m-%dT%H:%M:%S%z')\", \
    \"event\": \"log\", \
    \"level\": \"$logLevel\", \
    \"message\": \"$safeMsg\" \
  }" >> "$LOGFILE"
done
