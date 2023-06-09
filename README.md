<p align="center">
  <img src="https://raw.githubusercontent.com/gregorywmorris/dcj-manufacturing-oil-rig/main/images/energy-mobile-logo2.jpg" alt="logo"/>
</p>


Data Career Jumpstart - unguided project

## Project Prompt:
Oil wells can make $500,000+ / day, so these machines are highly valuable. Making sure we run them with data will be huge for our company. 

The data set comes from a real hydraulic rig system. This hydraulic rig is used to drill oil out of the ground. It has 4 main controls: the cooler setting, the valve setting, the pump setting, and the accumulator setting. The rig has sensors in different areas measuring the pressure, volumetric flows, and temperatures.

The technicians have been running tests for maintenance and the data scientists believe the data may be useful for additional oil well analysis. This is for the Texas location only. 
**Objectives:**
1. Convert the files to CSV for the data scientist.
    * See the example template CSV for the desired format.
    * Add profile data - numerical and descriptive
1. Migrate the data to a database for future use.
1. Add missing data:
    * Add a date-time column.
    * The data is considered as recorded every 60 minutes for project purposes. 

### Starting Knowledge
1. Global locations. See `locations.py`.
1. There are 60 oil wells at each location.
1. The start date is 4/26/2018.
1. Tests are run in 3-month cohorts.
1. Data collection:
    * All changes must be done after you receive the data.
    * The data is collected in 3-month cohorts starting at midnight on the first day. 
    * The last day will be a few hours short for scheduled maintenance after each cohort.
1. There is only one profile.txt; reuse the data for each oil well.
1. The scientists use AWS Sagemaker.

## System Design
* Data: 
    * Currently in table format and is tab-delimited.
    * Used internally.
        * Consistent load.
        * Limited access.
    * Data is provided in 3-month batches/cohorts.
    * Once processed, the data is nearly **70 million** rows.
        * At 70 million rows every 3 months, that is a data growth rate of 280 million rows a year.
        * In 4 years, there will be over 1 billion rows. 
    * Data scientists want access to CSV format and use AWS Sagemaker.
    * Missing data needs to be added.
* SOLUTION: ETL over ELT; missing data is added before the upload. While the script is long-running, it is simple and allows the data to be useful in a more timely manner.
* SOLUTION: Use onsite MySQL. Database: `energymobile`
    * REASON: The limited data volume and limited use do not justify cloud expense when cheap local storage is available. 
* SOLUTION: Export a CSV from the database and import it to an S3 bucket. CSV: `oil-well-data-all-historical`
    * REASON: S3 will allow Sagemaker to have access to the data and CSV is the desired format. Creating the CSV from a database query is more efficient than scripting a program to create a combined CSV from the text files.
* Database schema:
    * [Figjam](https://www.figma.com/file/wblGp1sxj3uJhKLCxmVHuY/energymobile---database-design?type=whiteboard&node-id=0-1&t=oId6SLpAnpLL8sIR-0) (see Star schema below)
* Process flow:
    * Initial: Manual batch processing to get historical data into production.
    * Future state: Schedule processing at the end of every cohort. Additional clarification is needed from operations for the long-term management of new and archived data.
        * Is there a lag time in data availability once the cohort completes?
        * Can the data be provided at a set date and time?
        * Can the format or information be modified by the sending system?
        * Do we have any operational requirements for the tab data to remain available or to remain in the archive for a specific time? 

![system design](images/system-design.jpg)

![database design](images/energy-mobile-er-diagram.png)

# Implementation
###### Infrastructure
1. `bash locations.sh` to create destination folders.
1. `bash docker.sh` to create the Docker official MySQL image. 
1. Run the `db_creation.sql` query Mysql Workbench; creates the database in MySQL.
1. Create an AWS S3 bucket using AWS command line / Terraform with `s3-terraform.tf`.
###### ETL
1. Import the oil well sensor logs into the logs folder and import the profile file into the profile folder.
1. Run the `profile-csv.py` script; converts the profile file to CSV.
1. Run the `tab-to-csv.py` script; converts sensor logs to CSV for each location.
    * Data is pulled from the same directory and processed into different folders to simulate multi-location data. This will generate over 69.7 million rows of data.
    * *WARNING*: This will take over 6 hours to run all folders at once. 
1. Run the `import-mysql.py` script; import the log and profile CSV data to MySQL.
1. Run the `export_from_db.sql` query in MySQL and save the output as a CSV to the aws_s3 folder.
1. Run the `aws-upload.py` script; Uploads the database export CSV to the aws s3 folder.
1. Run the `archive.py` script; archives the log, profile, and AWS directory CSVs.


