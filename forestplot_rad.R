library(forestplot)

Features <- c("First_order_energy", "Original_glrlm", "Original_shape_MeshVolume ", "Original_shape_Sphericity", "Wavelet.HLH_glrlm")
#Features <- c("Chemoradiotherapy","T3 or Higher","N2 or Higher","HPV Positive", "HPV #Negative")
HR1 <- c(1.72,1.66,1.28,0.72,1.58)
HR2 <- c(2.37,0.87,1.12,0.84,0.66)
lower1 <- c(1.52,1.47,1.20,0.65,1.40)
lower2 <- c(1.43,0.49,1.05,0.75,0.41)
upper1 <- c(1.94,1.89,1.37,0.80,1.79)
upper2 <- c(3.94,1.54,1.25,0.95,1.06)
p.value1 <- c(0.0001,0.0001,0.0001,0.0001,0.0001)
p.value2 <- c(0.0001,0.654,0.002,0.010,0.157)
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
           boxsize = 0.2,
           txt_gp = fpTxtGp(cex=0.75),
           legend = c("Univariate", "Multivariate"), 
           vertices = TRUE)

