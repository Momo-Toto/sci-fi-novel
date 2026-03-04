#!/bin/bash

echo "Checking GitHub token permissions..."
echo ""

# Try to get token scopes
REQUEST="GET /user HTTP/1.1\r\n"
REQUEST="${REQUEST}Host: api.github.com\r\n"
REQUEST="${REQUEST}User-Agent: OpenClaw/1.0\r\n"
REQUEST="${REQUEST}Authorization: token $GITHUB_TOKEN\r\n"
REQUEST="${REQUEST}Accept: application/vnd.github.v3+json\r\n"
REQUEST="${REQUEST}Connection: close\r\n"
REQUEST="${REQUEST}\r\n"

echo -e "$REQUEST" | timeout 5 openssl s_client -connect api.github.com:443 -quiet 2>/dev/null | {
    # Read status
    read -r status
    echo "Status: $status"
    
    # Read headers and look for X-OAuth-Scopes
    while IFS= read -r line; do
        if [ -z "$line" ]; then
            break
        fi
        if [[ "$line" == *"X-OAuth-Scopes:"* ]]; then
            echo "Token scopes: $line"
        fi
        if [[ "$line" == *"X-Accepted-OAuth-Scopes:"* ]]; then
            echo "Accepted scopes: $line"
        fi
    done
    
    # Read body
    echo ""
    echo "Response body:"
    cat
}