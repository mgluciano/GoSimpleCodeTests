# Payment Processing
This monitoring application will check our IOT DB every LoopFreqMinutes minutes for Invalid Order Stats
 With each scan all kiosks with Payment Processing > 1 (X) will be checked to see if in the prior (>= 10 minutes ago) a status message with >= X+1 Payment Processing.

 **An alert to the slack channel eng-devops-triage will occurs if all of the below:**
 * kiosk has three status messages with Payment Processing
 * within time frame of the three status messages there was no decrease in Payment Processing
 * The three status messages happened in > 20 minutes as only the most recent status message is recorded for future checks

## Requirements
- Docker Service Running
- .env file created from sample_env with needed production DB password and user name added
- Seven parameters established in .env File:
1. DB_R_Host = DB Host to Read From
2. DB_Password = DB Password needed to connect
3. DB_User = DB User for login
4. DB_Name = Name DB to connect to
5. DB_Port = PORT DB is connected on
6. PORT = PORT monitor should run on for validation


## SAMPLE .env file
```
>cat .env
DB_R_Host=prd-iot-slave.bytetech.co
DB_Password=ADD_DB_PASSWORD
DB_User=ADD_DB_USER
DB_Name=pantry
DB_Port=5432
PORT= 9093
```


## Setup
1. Download Monitoring report
2. Navigate to the Monitoring/payment_processing folder
3. Create .env file from sample_env
4. Update .env file with production DB user name and password
5. Run buildAndRunPaymentProcessing.sh from payment_processing folder with port assigned in .env file

### SAMPLE
```
git clone https://github.com/bytetechnology/Monitoring.git
cd Monitoring
cd payment_processing
sh buildAndRunPaymentProcessing.sh 9090

```
## Details
* Requires running Docker Services
* Polls Every LoopFreqMinutes minutes (constant defaulted initialy set to 11)
* appends logs to payment_processing/payment_processing.log
* Could be run as a screen task or nohup until built into a docker swarm cluster

## Possible Next Steps
* Should be built into a docker swarm cluster
* Added to a CICD pipeline using Circle CI
* Final Docker Container can be pushed to docker hub or ? to remove repo dependencies.
* Env attributes should be stored as secrets in Circle CI or GCLOUD
* Send all logs to graylogs

## Run
Run the shell buildAndRunPaymentProcessing.sh from payment_processing folder
```
sh buildAndRunPaymentProcessing.sh 9090
```
