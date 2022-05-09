# MA679_midterm

## The setup

A company wants to hire data scientists from pool of people enrolled in the courses conduct by the company. The company wants to know which of these candidates are looking to change their job.  Information related to demographics, education, experience are in hands from candidates signup and enrollment.  In this exam, your goal is to predict if the candidate is looking for a new job or will work for the current company. 

- uid : Unique ID for candidate
- city: City code
- city_dev_index : Development index of the city (scaled) 
- gender: Gender of candidate
- relevant_experience: Relevant experience of candidate
- enrolled_university: Type of University course enrolled if any
- education_level: Education level of candidate
- major_discipline :Education major discipline of candidate
- experience_years: Candidate total experience in years
- company_size: No of employees in current employer's company
- company_type : Type of current employer
- lastnewjob: Difference in years between previous job and current job
- training_hours: training hours completed
- change_job: 0 – Not looking for job change, 1 – Looking for a job change


## Your task

Your task for this take home portion of the midterm is three fold.
1. (50pts) First, you are to train your model based on the `train_sample` and make prediction on `test_sample.csv` and put your prediction in the `submission.csv`.  The result will be evaluated in the following way. 
- For every correctly identified candidate you get 1 point.
- For every 3 incorrectly identified candidate you loose a point.
The final result will be normalized to amount to 100.

2. (30pts) Second, you are to document all of your decisions that went into the prediction on the Rmd file.  

3. (20pts) Lastly, you are to promote your work on the Flipgrid
