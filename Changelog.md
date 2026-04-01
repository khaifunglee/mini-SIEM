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
- Added grok patterns to parse different types of log formats
- Added if/else conditional logic to further categorize logs by adding tags and/or field manipulation for each log
- Practiced KQL querying to verify successful log parsing in Kibana
- Built a custom Docker logstash image to bake config into image due to file reading issues

### 30-03-2026:

**Built a Professional Security Dashboard on Kibana**:
- Created 8+ visualizations types such as a metric for critical alerts, line graph for security events timeline, stacked bar chart for user login attempts, etc.
- Filtered and aggregated data to allow for visual analysis of security events
- Arranged them in a cohesive layout on Kibana

<img width="2880" height="3538" alt="image" src="https://github.com/user-attachments/assets/5d76ea3c-bd0a-481b-a614-1929ff62d5a6" />

### 01-04-2026:

**Created Detection Rules on Kibana**:
- Created practical detection rules by creating saved queries on Kibana
- Set a threshold for each detection rule for manual detection
- Created a secondary security detection dashboard to help conduct manual investigation workflows
- Practiced threat hunting by searching for targeted queries (e.g tags: "sensitive_path", group by client_ip.keyword)

Manual investigation workflow: 
1. Click on suspicious value 
2. Expand time range to "Last 24 hours"
3. Look for patterns such as: same repeated username/client IP, time patterns, multiple critical security events
4. Check for related events: search filtered queries such as client_ip : "203.xx" to further investigate

## Next Steps
**1. Create detection rules to detect suspicious activity**
  - Add automated alerting by enabling Elasticsearch alerting features

**2. Add more log sources to add variety**
  - Add Docker container logs
  - Add a Cloud VM to enable distributed log collection

**3. Follow security best practices (for production)**
  - Enable authentication: `xpack.security.enabled=true`
  - Use HTTPS to encrypt traffic between components
  - Follow principle of least privilege
  - Segregate networks by using isolated Docker networks
  - Rotate logs to avoid storage overflow
  - Ensure no sensitive information is displayed in the repository

**4. Documentation**
  - Add Filebeat configuration in README for guidance
  - Polish up documentation and test redeployment of environment
