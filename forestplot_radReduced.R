library(forestplot)

Features <- c("First_order_energy", "Original_shape_MeshVolume ", "Original_shape_Sphericity", "Wavelet.HLH_glrlm")
HR <- c(2.21, 1.14, 0.85, 0.61)
lower <- c(1.46, 1.05, 0.75, 0.41)
upper <- c(3.34, 1.25, 0.95, 0.92)
p.value <- c(1e-07, 0.002, 0.012, 0.058)
dummydata <- data.frame(Features, HR, lower, upper, p.value)

tabletextdummy2<- cbind(c("Features", dummydata$Features),
                        c("HR", dummydata$HR),
                        c("CI lower", dummydata$lower),
                        c("CI upper", dummydata$upper),
                        c("p-value", dummydata$p.value)
)

forestplot(tabletextdummy2, 
           mean= cbind(c(NA, dummydata$HR)),
           lower = cbind (c(NA,dummydata$lower)), 
           upper = cbind(c(NA,dummydata$upper)),
           xlog = TRUE, xlab = "HR with 95% CI", 
           clip = c(0.1,4),
           col = fpColors(box = c("red4"), 
                          lines = c("red3")),
           boxsize = 0.2,
           txt_gp = fpTxtGp(cex=0.75),
           fn.ci_norm = fpDrawDiamondCI,
) 

