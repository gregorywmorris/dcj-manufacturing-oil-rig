<p align="center">
  <img src="https://raw.githubusercontent.com/gregorywmorris/dcj-manufacturing-oil-rig/main/images/energy-mobile-logo2.jpg" alt="logo"/>
</p>


Data Career Jumpstart - unguided project

## Project Prompt:
Oil wells can make $500,000+ / day, so these machines are highly valuable. Making sure we run them with data will be huge for our company. The technicians have been storing the oil well test in text files locally, the data scientists would like to review the data but it's not in a usable format. 
1. Convert the files to CSV for the data scientist.
    * See the example template CSV for the desired format.
    * Add profile data.
    * The scientists use AWS Sagemaker.
3. Migrate the data to a database for future use.
4. Complete missing data:
    * Add a date-time column.
    * Provide cumulative 60-minute intervals.

### Starting Knowledge
1. There are 15 years' worth of data.
2. The start date is 3/26/2008.
3. Data collection:
    * Data comes from legacy systems, all changes must be done after you receive the data.
    * The data is collected in 3-month cohorts starting at midnight on the first day. 
    * Data is considered as recorded every 60 minutes for project purposes. 
    * The last day will be a few hours short for scheduled maintenance after each cohort.
4. There is only one profile.txt, reuse data as if there was one for each cohort.

## System Design
* Data: 
    * Currently in table format and is tab-delimited.
    * Used internally and does not meet the requirements of big data. 
    * Data is provided in 3-month batches/cohorts.
    * Data scientists need access to CSV format and use AWS Sagemaker.
    * SOLUTION: Use the current onsite MySQL database
        * REASON: The limited data volume and limited use do not justify cloud expense when cheap local storage is available. 
    * SOLUTION: Export a CSV from the database and import it to the S3 bucket. 
        * REASON: This will allow Sagemaker to have access to the data in the desired format. Creating the CSV from a database query is more efficient than scripting a program to create the CSV from the text files.
* Database schema:
    * [Figjam](https://www.figma.com/file/wblGp1sxj3uJhKLCxmVHuY/energymobile---database-design?type=whiteboard&node-id=0-1&t=oId6SLpAnpLL8sIR-0) (see Snowflake schema below)
* Process flow:
    * Initial: Manual batch processing to get historical data into production.
    * Future state: Schedule processing at the end of every cohort. Additional clarification is needed from operations.
        * Can the data be provided at a set date and time?
        * Is there a lag time in data availability once the cohort completes?
        * Can the format or information be modified by the sending system?

![system design](images/system-design.jpg)

![database design](images/db-design.jpg)

# Implementation
1. Imported oil well sensor logs into the logs folder and import the profile file into the profile folder.
2. Run the `db_creation.sql` to create the database in MySQL.
3. Run the `tab-to-csv.py` script; converts sensor logs to CSV.
4. Run the `profile-csv.py` script; converts the profile file to CSV.
5. Run the `import-mysql.py` script; imports all CSV data to MySQL and archive the sensor CSVs.
6. Run the `export_from_db.sql` query in MySQL and save the output as a CSV to the aws_s3 folder.
7. Run the `upload-aws.py` script; creates a bucket if does not exist, upload the CSV in the aws_s3 folder to AWS S3, and archive the CSV.
 
