# Nginx Logs Analyzer

A simple Bash script to analyze Nginx access logs and extract useful insights such as the most active IP addresses, most requested paths, most frequent HTTP response codes, and most common user agents.

## Author
By **@MikeMin**

## Features

- Extracts unique IP addresses and counts request frequency
- Identifies the top 5 most requested paths
- Displays the top 5 HTTP response status codes
- Lists the top 5 most common user agents

## Requirements

- Bash
- `awk`, `sort`, `uniq`, `grep`, `wc` — standard Unix tools

## Usage

```bash
./analyze.sh nginx-access.log
```

Replace nginx-access.log with the path to your actual Nginx access log file.
Output

The script will output the following statistics in the terminal:

    Top 5 IP addresses by number of requests

    Top 5 most requested paths

    Top 5 response status codes

    Top 5 user agents

Notes

    The script generates intermediate files: ips.log, paths.log, codes.log, agents.log, and temp.log.

    temp.log is deleted automatically after execution.

    Make sure the log file follows the standard Nginx log format.

## Roadmap.sh Project
Project URL: https://roadmap.sh/projects/nginx-log-analyser
