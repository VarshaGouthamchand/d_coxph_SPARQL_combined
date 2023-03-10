source("Client.R")
source("dl_coxph.R")
client <- Client("http://35.157.139.38:5000/api", "varsha", "password", 1) #please replace with correct username and password
client$authenticate()

# Parameters used to interpret the hub's datastore
#expl_vars <- c("firstorderenergy", "orig_glrlm", 
#              "volume","sphericity" ,"wav_glrlm")
expl_vars <- c("lp_clin", "lp")
time_col <- "overall_survival_in_days"
censor_col <- "event_overall_survival"

results <- dcoxph(client, expl_vars, time_col, censor_col)
results

# # #create input from results
firstorderenergy  = c(results$coef[1])
volume = c(results$coef[2])
sphericity = c(results$coef[3])
wav_glrlm = c(results$coef[4])
#N2orHigher = c(results$coef[5])
#inputDf1 = data.frame(Treatment_ChemoRadiotherapy,T3orHigher,HPV_HPV_Positive,HPV_HPV_Negative,N2orHigher,firstorderenergy)
inputDf1 = data.frame(firstorderenergy,volume,sphericity,wav_glrlm)
library(jsonlite)
input=toJSON(inputDf1)
input

Treatment_ChemoRadiotherapy <- -0.89058
T3orHigher <- 0.94548
HPV_HPV_Positive <- -0.16381
HPV_HPV_Negative <- 0.87626
N2orHigher <- 0.26724
input_test = data.frame(Treatment_ChemoRadiotherapy, T3orHigher, HPV_HPV_Positive, HPV_HPV_Negative, N2orHigher)
input_test_data=toJSON(input_test)
input_test_data

firstorderenergy <- 0.79121
volume <- 0.13441
sphericity <- -0.16411
wav_glrlm <- -0.48628
input_test_rad = data.frame(firstorderenergy, volume, sphericity, wav_glrlm)
input_test_data_rad=toJSON(input_test_rad)
input_test_data_rad

lp_clin <- 0.36170
lp <- -0.01944
input_com = data.frame(lp_clin, lp)
input_com_rad=toJSON(input_com)
input_com_rad

# # # create and post task
source("validate_task.R")
task = postTask(client,input_com_rad)
print(task)