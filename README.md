# TCP Check

Checks for open TCP ports based on the exit code returned by the tcp command.

Usage:
    tcpcheck.sh [-h <hostname>] [-p <port>|<start_port>-<end_port>]

Options:
    -h <host>   The target hostname or IP address (default: localnost)

    -p <port>|<start_port>-<end_port>
                The port or port range to scan (default: 22).
