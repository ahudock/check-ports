# TCP Check

Checks for open TCP ports using tcp exit codes. This method isn't particularly elegant or
efficient, but it can be helpful when your other network mapping tool is being blocked/filtered by a firewall.

Usage:

    tcpcheck.sh [-h <hostname>] [-p <port range>]

Options:

    -h <host>   The target hostname or IP address (default: localhost).

    -p <port>|<start_port>-<end_port>
                The port or port range to scan (default: 22). The port range is scanned
                sequentially from <start_port> to <end_port> (not yet optimized or randomized).
