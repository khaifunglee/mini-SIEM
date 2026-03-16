# Changelog

## Description
This document aims to serve as my notes and a timeline of this project as I continue to build this mini-SIEM project.

## Versions

### 31-01-2026

**Initial Setup**:
- Setup ELK stack on Docker with 3 separate containers
- Installed Filebeat and configured settings to connect to Logstash
- Created data view on Kibana to verify basic system logs are being collected on host PC

### 16-03-2026:

**Added Log Source**:
- Added a new log source to simulate application logs by writing a bash script that generates log messages
- Configured Filebeat to receive this log input and only include error and warning messages
- Added processors to enrich and clean logs before sending to Logstash

## Next Steps

2. Parse logs with Grok patterns in Logstash to extract useful information from raw logs
  - Add grok patterns to extract new fields
  - Add conditional logic to tag certain events

3. Build a professional security dashboard 
  - Create more visualizations in Kibana
  - E.g: Total events over time (Line Chart), Top client IPs (Bar Chart), HTTP response codes (Pie Chart), Failed vs Successful requests (Metric), Requests to sensitive paths (Data Table)
  - Practice KQL queries to find specific events

4. Create detection rules to detect suspicious activity
  - Create saved searches on Kibana
  - E.g: Multiple 404 errors from the same IP, Access to admin paths, Unusual traffic volume
  - Add alerting by enabling Elasticsearch alerting features

5. Add more log sources to add variety
  - Add Docker container logs
  - Simulate failed authentication attempts
  - Add a Cloud VM to enable distributed log collection

6. Follow security best practices (for production)
  - Enable authentication: `xpack.security.enabled=true`
  - Use HTTPS to encrypt traffic between components
  - Follow principle of least privilege
  - Segregate networks by using isolated Docker networks
  - Rotate logs to avoid storage overflow
  - Ensure no sensitive information is displayed in the repository

7. Documentation
  - Add Filebeat configuration in README for guidance