library(xlsx)

vote_counting_data <- read.xlsx("Visualization_1.xlsx", sheetName="Election_Vote_Counting")
candidate_data <- read.xlsx("Visualization_1.xlsx", sheetName="Candidate")
location_data <- read.xlsx("Visualization_1.xlsx", sheetName="Location")
party_data <- read.xlsx("Visualization_1.xlsx", sheetName="Party")
past_year_data <- read.xlsx("Visualization_1.xlsx", sheetName="Past_Yr_Results")
campaign_data <- read.xlsx("Visualization_1.xlsx", sheetName="Campaign")

# Sample submission: http://datahack.analyticsvidhya.com/media/sample_submission/Visualization_2.pdf

# What use is the data, if you can not create a story out of it?
# This is what you need to do this time - use the data to create a story out of it.
# But it wouldn't end there - you need to create story for a billion people nation.
# Your client is one of the top media houses in country and they want to prepare data based stories to be shared during the counting of votes.
# In order to do a dry run, they have provided sample data and minute by minute update on votes of various candidates.

#You can take some inspiration from the work here:
# http://www.ndtv.com/elections
# https://en.wikipedia.org/wiki/Results_of_the_Indian_general_election,_2014
# http://www.nytimes.com/interactive/2012/02/13/us/politics/2013-budget-proposal-graphic.html

# Judging Criteria
# The best submission would be judged by Analytics Vidhya based on the following parameters:
# Efficient usage of space
# Depth in the story
# Breadth of the story
# Chart / Story fit for purpose of news broadcasting
# Quality of insights and usefulness of the dashboard for the client

# Expectations:
# We have provided a dummy dataset of past performance for you to understand what data is available
# Using this data (or any open data available), you need to create a dashboard / visualization / story which can be used by the media house during the day of election vote counting.
# You need to upload a design document containing wire frames and details of your visualization
# While designing the dashboard, ask the following:
#   What could be the metrics the media house and the audience would be most interested in?
#   How can you summarize the commonly asked questions in the most effective manner?
# Remember the best dashboard / data visualization is like a joke, it is bad if you need to explain it!

# OK, first visualizations are votes growth depending on time for every particular candidate
library(ggplot2)
library(ggthemes)

pdf("Voice_chart.pdf", width = 12, height = 8)
ggplot(data = vote_counting_data,
       mapping = aes(x = Vote_Counting_DateTime, y = Number.of.Votes_Cumulative)) +
  geom_bar(mapping = aes(fill = Location_ID), stat = "identity") +
  xlab("") + ylab("Voice Cumulative Count") +
  facet_wrap( ~ Candidate_ID) + theme_solarized()
dev.off()

# Plot population by categories at every location available

# Reorganizing the data set first
library(tidyr)
reorganized_location_data <- gather(location_data, Population_Categories, Percentage, Population.Category.A.:Population.Category.Other.)
ggplot(reorganized_location_data, aes(Population_Categories, Percentage)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ Location_ID)

ggplot(reorganized_location_data, aes(Population_Categories, fill = Percentage)) + geom_bar() +
  labs(title = "Stacked Bar Chart", x = "Outlet Location Type", y = "Count of Outlets") +
  facet_wrap(~ Location_ID)

ggplot(reorganized_location_data, aes(Item_MRP)) + geom_histogram(binwidth = 2, aes(color = Item_Type)) +
  scale_x_continuous("Item MRP", breaks = seq(0,270,by = 30)) +
  scale_y_continuous("Count", breaks = seq(0,200,by = 20)) +
  labs(title = "Histogram")

ggplot(data = reorganized_location_data,
       aes(x = factor(1), y = Percentage, fill = factor(Population_Categories))) +
  geom_bar(width = 1, stat = "identity") +
  facet_grid(facets = Population_Categories ~ Location_ID)


