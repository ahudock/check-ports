#!/bin/bash
#
# TCP Check
#
# Checks for open TCP ports using tcp exit codes. This method isn't particularly elegant or efficient,
# but it can be helpful when your other network mapping tool is blocked/filtered by a firewall.
#
# @author: Andy Hudock <ahudock@pm.me>
#
# Usage:
#   tcpcheck.sh [-h <hostname>] [-p <port>|<start_port>-<end_port>]
#
# Options:
#   -h <host>   The target hostname or IP address (default: localhost)
#
#   -p <port>|<start_port>-<end_port>
#               The port or port range to scan (default: 22). The port range is scanned
#               sequentially from <start_port> to <end_port>
#
# TODO:
#   [ ] Add option for writing to log file
#   [ ] Randomize port range scan by default; optionally sequential
#   [ ] Scan top 1000 ports by default
#   [ ] Scan top 1000 ports first if range
#   [ ] Support multiple port ranges
#   [ ] Add timeout option
#   [ ] Add verbose mode to echo tcp command exit codes
#   [ ] Add options to display only open or closed ports
#   [ ] Display config. settings at beginning of scan
#   [ ] Display summary upon completion of scan
#

# Default values
host="localhost"
start_port="22"
end_port="22"

# Parse command-line options
while getopts ":h:p:" opt; do
    case ${opt} in
    h)
        host=${OPTARG}
        ;;
    p)
        if [[ ${OPTARG} == *"-"* ]]; then
            IFS='-' read -ra ADDR <<<"${OPTARG}"
            start_port=${ADDR[0]}
            end_port=${ADDR[1]}
        else
            start_port=${OPTARG}
            end_port=${OPTARG}
        fi
        ;;
    ?)
        echo "Invalid option: $OPTARG" 1>&2
        exit 1
        ;;
    :)
        echo "Invalid option: $OPTARG requires an argument" 1>&2
        exit 1
        ;;
    esac
done
shift $((OPTIND - 1))

# Print column headers
printf "%-5s %-10sn" "PORT" "STATUS"

# Check if each port in the range is open
for ((port = start_port; port <= end_port; port)); do
    if timeout 1 bash -c '</dev/tcp/'${host}'/'${port} 2>/dev/null; then
        printf "%-5s %-10sn" ${port} "open"
    else
        printf "%-5s %-10sn" ${port} "closed"
    fi
done
