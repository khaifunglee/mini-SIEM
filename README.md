# Mini-SIEM Project

## Description
This project aims to teach cybersecurity concepts such as event management, log collection and ingestion, ELK stack pipeline by creating a self-hosted mini-SIEM running in Docker.

## Architecture
Log Sources -> Filebeat -> Logstash -> Elasticsearch -> Kibana

## What I Built
- ELK Stack running in Docker
- Collecting system logs and nginx access logs from MacBook
- [Parsing logs to extract security-relevant fields]
- Dashboard showing security metrics
- [Detection rules for suspicious activity]

## Setup

1. After cloning the repository, navigate to the directory and start all containers in detached mode:
`docker-compose up -d`
 - You can use `docker-compose ps` to confirm the status of all containers are running.

2. Since the ELK stack is running in version 8.11, install Filebeat 8.11, then navigate to the directory to configure `filebeat.yml`. Your config file should look like this to collect logs on your host PC:

3. Test Filebeat configuration with `sudo ./filebeat test config`.

4. Test connection to Logstash with `sudo ./filebeat test output`.

5. Start Filebeat to collect logs with `sudo ./filebeat -e`.

6. Navigate to http://localhost:5601 to access Kibana and verify the logs are being collected with:
 - Navigate to Discover under "Analytics"
 - Create a data view: Name "logs", Index pattern "logs-*", Timestamp field "@timestamp"
 - You should now see logs appearing

### Filebeat Configuration

This configuration accepts two log inputs: system and install logs from your host PC, and application logs generated from the bash script `generate-logs.sh`.

 ```
    filebeat.inputs:
    - type: log
      enabled: true
      paths:
      - /var/log/system.log
      - /var/log/install.log

    # Custom log source - application logs from test-app
    - type: log
      enabled: true
      paths:
        - /Users/[put in the correct path to your generate app logs]/test-app/logs/app.log

      # Add custom fields to identify this source
      fields:
        log_source: test_app
        environment: development
      fields_under_root: false

      # Add tags to identify this source
      tags: ["test-app", "custom"]

      # Exclude DEBUG and INFO logs
      exclude_lines: ['^\[.*\] \[DEBUG\]', '^\[.*\] \[INFO\]']

      # Only include ERROR and WARN logs (Optional)
      #include_lines: ['^\[.*\] \[ERROR\]', '^\[.*\] \[WARN\]']
 ```
 ```
    #output.elasticsearch:
      #hosts: ["localhost:9200"]

    output.logstash:
      hosts: ["localhost:5044"]
 ```

## Structure
This section lays out the structure of the project directory and serves to explain the purpose of each file.

## Skills Learned
- Docker containerization
- Log analysis & SIEM concepts
- Data visualization
- Security event detection
- [Grok pattern parsing]

## Challenges Overcome
- Simulating log sources due to limited space, fixed by simulating application logs by creating a log generation script

## Screenshots
- Dashboard
- Parsed logs
- Detections