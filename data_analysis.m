function data_analysis

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Load each group files seperately.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%You need to change the directory where this script scans to where all the patient .mat
%files are

%In my case:
data_folder = 'E:\MatLab\z_assets\Final Project files';

%Indicate which group, thus, what kind of files to obtain
group1 = fullfile(data_folder, '*1.mat');

all_g1_files = dir(group1);
for i = 1:length(all_g1_files)
    filename = all_g1_files(i).name;
    load(filename, 'ave_correct_choice');
    group1_score_vector(i) = ave_correct_choice;
end

%Do the same for the other group, but save their scores in a different
%vector

%clear the ave_correct_choice variable so group 2 scores are different.
clear ave_correct_choice

group2 = fullfile(data_folder, '*2.mat');

all_g2_files = dir(group2);
for i = 1:length(all_g2_files)
    filename = all_g2_files(i).name;
    load(filename, 'ave_correct_choice');
    group2_score_vector(i) = ave_correct_choice;
end

%Now we should have two vectors that each contains the scores for their
%respective groups

%But we have to check to make sure that the number of participants in each
%group are equal to eachother before the paired sample t-test

if length(all_g2_files)~= length(all_g1_files)
    error('The two groups you are comparing do not have the same sample size!')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Run the paired sample t-test for the 2 groups loaded
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Group 1 in our case is the control group
%Group 2 in our case is the alcohol group

[h,p,ci,stats] = ttest(group2_score_vector, group1_score_vector)

%display whether we rejected or accepted the null hypothesis and p value

if h == 1
   disp("Rejected null hypothesis, and the p-value was: " + p)
elseif h ~= 1
   disp("Accepted null hypothesis, and the p-value was: " + p)
end

%Save stats data into a .mat file

filename = "analysis_results";
save(filename, 'h','p','ci','stats')




