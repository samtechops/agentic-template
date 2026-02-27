#!/bin/bash

# Generic development server start script
# CUSTOMIZE: Add your service start commands below

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting development environment...${NC}"

# Get the script's directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( dirname "$SCRIPT_DIR" )"

# Function to cleanup on exit
cleanup() {
    echo -e "\n${BLUE}Shutting down services...${NC}"
    jobs -p | xargs -r kill 2>/dev/null
    wait
    echo -e "${GREEN}Services stopped successfully.${NC}"
    exit 0
}

# Trap EXIT, INT, and TERM signals
trap cleanup EXIT INT TERM

# CUSTOMIZE: Add your service start commands here
# Example:
# echo -e "${GREEN}Starting backend...${NC}"
# cd "$PROJECT_ROOT/app/server"
# your-start-command &
# BACKEND_PID=$!
#
# echo -e "${GREEN}Starting frontend...${NC}"
# cd "$PROJECT_ROOT/app/client"
# your-start-command &
# FRONTEND_PID=$!

echo -e "${RED}No services configured. Edit scripts/start.sh to add your start commands.${NC}"
echo "See the CUSTOMIZE comments in this file for examples."
exit 1

# Uncomment after adding your services:
# echo -e "${GREEN}Services started successfully!${NC}"
# echo "Press Ctrl+C to stop all services..."
# wait
