---
title: "Codebook"
author: "Ronen"
date: "Thursday, September 18, 2014"
output: html_document
---

I wanted to capture how the combined dataset of training and test data evolve after each transformation, specifically how the dimensions of the data frame are changing.

Transformation| Variable Name | Description | Observations | Variables |
---| --------------|---------------------------|--------------|-----------|
1  | train | training data | 7352 | 561 |
1  | test | test data | 2947 |561 |
1  | merge | combined training and test data into a single data frame| 10299 | 561 |
2 | measurements | measurements on the mean and standard deviation | 10299 | 66 |
3 | trainActivity | train activity data | 7352 | 1 |
3 | train | combine training and activity data | 7352 | 562 |
3 | testActivity | test activity data | 2947 | 1 |
3 | merge | combined dataset after adding the activity code | 10299 | 562 |
3 | merge | combined dataset after adding the activity name | 10299 | 563 |
5 | trainSubject | train subject data | 7352 | 1 |
5 | testSubject | test subject data | 2947 | 1 |
5 | subject | combined subject data | 10299 | 1 |
5 | merge | combined dataset after adding subject data | 10299 | 564 |
6 | tidy | averages for each activity and subject | 180 | 480 |


