# Mini-SIEM Project

## Description
This project aims to teach cybersecurity concepts such as event management, log collection and ingestion, ELK stack pipeline by creating a self-hosted mini-SIEM running in Docker.

## Architecture
Log Sources -> Filebeat -> Logstash -> Elasticsearch -> Kibana

## What I Built
- ELK Stack running in Docker
- Multiple log sources with Bash scripts simulating application, authentication, and web access logs
- Collecting system logs and nginx access logs from MacBook with Filebeat
- Parsing logs to extract security-relevant fields with Logstash
- Dashboard showing security metrics with Kibana
- Detection rules for suspicious activity with Kibana

## Setup

1. After cloning the repository, navigate to the directory and start all containers in detached mode:
`docker-compose up -d`
 - You can use `docker-compose ps` to confirm the status of all containers are running.

2. Since the ELK stack is running in version 8.11, install Filebeat 8.11, then navigate to the directory to configure `filebeat.yml`. Filebeat configuration is in the section below this.

3. Test Filebeat configuration with `sudo ./filebeat test config`.

4. Test connection to Logstash with `sudo ./filebeat test output`.

5. Start Filebeat to collect logs with `sudo ./filebeat -e`.

6. Navigate to http://localhost:5601 to access Kibana and verify the logs are being collected with:
 - Navigate to Discover under "Analytics"
 - Create a data view: Name "logs", Index pattern "logs-*", Timestamp field "@timestamp"
 - You should now see logs appearing

### Filebeat Configuration

This configuration accepts four log inputs: system and install logs from your host PC, and logs generated from the bash scripts in the repo.

 ```
...

  filebeat.inputs:
  - type: log
    enabled: true

    # Paths that should be crawled and fetched. Glob based paths.
    paths:
    - /var/log/system.log
    - /var/log/install.log
    #- c:\programdata\elasticsearch\logs\*

  # Custom log source - application logs from test-app
  - type: log
    enabled: true

    paths:
    - /Users/[path to your repo]/mini-SIEM/test-app/logs/app.log

    # Add custom fields to identify this source
    fields:
      log_type: test_app
      log_source: siem_host
    
    fields_under_root: false

    # Add tags to identify this source
    tags: ["test-app", "application"]

    # Exclude DEBUG and INFO logs
    exclude_lines: ['^\[.*\] \[DEBUG\]', '^\[.*\] \[INFO\]']

    # Only include ERROR and WARN logs
    #include_lines: ['^\[.*\] \[ERROR\]', '^\[.*\] \[WARN\]']

    # Regex explanation: `^` indicates start of line, `\[.*\]` matches timestamp in message, `\[DEBUG\]` matches log status

  # Custom log source - SSH authentication logs from test-app
  - type: log
    enabled: true

    paths:
    - /Users/[path to your repo]/mini-SIEM/test-app/logs/auth.log

    fields:
      log_type: ssh_auth
      log_source: siem_host
    fields_under_root: false
    tags: ["test-app", "ssh", "authentication"]

  # Custom log source - web access logs from test-app
  - type: log
    enabled: true

    paths:
    - /Users/[path to your repo]/mini-SIEM/test-app/logs/web-access.log

    fields:
      log_type: web_access
      log_source: siem_host
    fields_under_root: false
  
    tags: ["test-app", "web", "http"]

...

  # Make sure output is pointing to logstash, not elasticsearch
    #output.elasticsearch:
      #hosts: ["localhost:9200"]

    output.logstash:
      hosts: ["localhost:5044"]

...

  # Basic log parsing for application logs, uncomment if not using logstash
  processors:
    # Extract app log fields like log level from message using dissect
    #- dissect: 
        #tokenizer: "[%{timestamp}] [%{log_level}] %{log_message}"
        #field: "message"
        #target_prefix: "app"

    # Add host information
    - add_host_metadata:
        when.not.contains.tags: forwarded

    # Drop unnecessary fields in logs
    - drop_fields:
        fields: ["agent.ephemeral_id", "agent.id", "ecs.version"]
        ignore_missing: true

    # Add a new field based on log level (alert=true and priority=high when log status="ERROR")
    #- add_fields:
        #when:
          #equals:
            #app.log_level: "ERROR"
        #target: ""
        #fields:
          #alert: true
          #severity: high

    - add_cloud_metadata: ~
    - add_docker_metadata: ~
    - add_kubernetes_metadata: ~
 ```

## Structure
This section lays out the structure of the project directory and serves to explain the purpose of each file.

## Skills Learned
- Docker containerization
- Log analysis & SIEM concepts
- Data visualization
- KQL queries
- Security event detection
- Grok pattern parsing and conditional logic

## Challenges Overcome
- Simulating log sources due to limited space, fixed by simulating application logs by creating a log generation script
- Docker was not able to mount Logstash configuration file from macOS due to possible file reading corruption, fixed by creating a logstash Dockerfile that bakes the config into the image

## Screenshots

### Dashboard
<img width="2880" height="3538" alt="image" src="https://github.com/user-attachments/assets/53507226-463d-4c42-8018-6197fe1c83fa" />

### Parsed logs
<img width="2880" height="1294" alt="image" src="https://github.com/user-attachments/assets/f9ed22d4-68b7-479e-9d4d-2d803803acd8" />
