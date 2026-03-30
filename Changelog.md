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

### 26-03-2026:

**Added Grok Pattern and Conditional Logic Parsing in Logstash**:
- Added two new log sources to simulate web access and authentication logs by writing bash scripts
- Configured Filebeat to receive these log inputs 
- Added grok patterns to parse each type of logs
- Added conditional logic to further categorize logs by adding tags and fields for each log
- Practiced KQL querying to verify successful log parsing in Kibana
- Built a custom Docker logstash image to bake config into image due to file reading issues

### 30-03-2026:

**Built a Professional Security Dashboard on Kibana**:
- Created numerous visualizations such as a metric for critical alerts, line graph for security events timeline, stacked bar chart for user login attempts, etc.
- Arranged them in a professional layout on Kibana. 

## Next Steps
1. Add more log sources

2. Parse logs with more Grok patterns in Logstash to extract useful information from raw logs

3. Improve upon professional security dashboard 
  - Create more visualizations in Kibana
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