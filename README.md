![system design](images/energy-mobile-logo-long.jpg)

Data Career Jumpstart - unguided project

## Project Prompt:
Oil wells can make $500,000+ / day, so these machines are highly valuable. Making sure we run them with data will be huge for our company. The technicians have been storing the well test in text files localy, the data scientists would like to review the data but it's not in a usable format. 
1. Convert the files to csv's for the data scientist.
    * The scientists use AWS Sagemaker and need the data in an S3 bucket so they can access it.
3. Migrate the data to a database for future use.
4. Complete missing data:
    * Fill in missing dates.
    * Provide cumlative 60 minute intervals

### Apriori
1. There are 15 years worth of data.
2. Start date is 3/26/2008.
3. Data collection:
    * Data comes from legacy systems, all changes must be doen after you recieve the data.
    * The data is collected in 3 month cohorts starting at midnight the first day. 
    * Data is considered as recorded every 60 minutes for project perposes. 
    * The last day will be a few hours short for schededuled maintence after each cohort.
4. There is only one profile.txt, reused as if there was one for each cohort.

## System Design
* Data 
    * Used internally and does not meet the requirements of big data. 
    * Currently in table format, whitespace deliminated.
    * Data is provided in 3 month batches.
    * Data scientists need access to csv's in AWS S3.
    * SOLUTION: Use current onsite MySQL database and S3 bucket.
* Database schema
    * [Figjam](https://www.figma.com/file/wblGp1sxj3uJhKLCxmVHuY/energymobile---database-design?type=whiteboard&node-id=0-1&t=oId6SLpAnpLL8sIR-0) 
* Process flow
    * Inital: Manual batch processing to get intial data into production.
    * Futurestate: Schedule processing at the end of every chort. Additional clarification needed from operations.
        * Can the data be provided at a set date and time?
        * Is there lag time in data availabiliy once the cohort completes?
        * Can format or information be modified by sending system?

![system design](images/system-design.jpg)
