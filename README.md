# Gamble-psychology-game
A matlab script that runs a gambling game for participants, collects their inputs, and performs statistical analysis all in one go.

# Setup
1. Have participants run the paradigm script : “value_assessment.m”
2. Their profiles will be saved into a .mat file when the experiment is over for them
3. Run the data analysis script: “data_analysis.m”
4. It will automatically load the save profile of both groups, sort them, check if the sample sizes are equal, then conduct a paired sample t-test on the group. Finally, it will tell you if the two groups performed statistically significantly different from each other.
