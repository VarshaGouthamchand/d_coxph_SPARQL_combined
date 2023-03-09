library(forestplot)

Features <- c("lp_clin", "lp_rad")
HR1 <- c(1.43,1.15)
HR2 <- c(1.44,0.98)
lower1 <- c(1.37,1.01)
lower2 <- c(1.37,0.86)
upper1 <- c(1.50,1.31)
upper2 <- c(1.50,1.12)
p.value1 <- c(2e-16,0.02)
p.value2 <- c(2e-16,0.8)
dummydata <- data.frame(Features, HR1, HR2, lower1, lower2, upper1, upper2, p.value1, p.value2)

sfrac <- function(top,bottom,data=NULL)
  with(data,lapply(paste0("atop(",top,",",bottom,")"),str2expression))

tabletextdummy2<- list(c("Features", dummydata$Features),
                       c("HR", sfrac(HR1,HR2,data=dummydata)),
                       c("CI lower", sfrac(lower1,lower2,data=dummydata)),
                       c("CI upper", sfrac(upper1,upper2,data=dummydata)),
                       c("p-value", sfrac(p.value1,p.value2,data=dummydata))
)

forestplot(tabletextdummy2, 
           mean= cbind(c(NA, dummydata$HR1), c(NA,dummydata$HR2)),
           lower = cbind (c(NA,dummydata$lower1), c(NA,dummydata$lower2)), 
           upper = cbind(c(NA,dummydata$upper1), c(NA, dummydata$upper2)),
           new_page = TRUE,
           clip = c(0.1,4),
           xlog = TRUE, xlab = "HR with 95% CI", 
           col = fpColors(box = c("skyblue3", "red4"), 
                          lines = c("skyblue2", "red3")),
           fn.ci_norm = c(fpDrawNormalCI, fpDrawDiamondCI),
           boxsize = 0.1,
           txt_gp = fpTxtGp(cex=0.75),
           legend = c("Univariate", "Multivariate"), 
           vertices = TRUE)

