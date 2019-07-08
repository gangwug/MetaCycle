## ------------------------------------------------------------------------
library(MetaCycle)
head(cycMouseLiverRNA[,1:5])

## ------------------------------------------------------------------------
set.seed(100)
row_index <- sample(1:nrow(cycHumanBloodDesign), 4)
cycHumanBloodDesign[row_index,]

## ------------------------------------------------------------------------
sample_id <- cycHumanBloodDesign[row_index,1]
head(cycHumanBloodData[,c("ID_REF", sample_id)])

## ------------------------------------------------------------------------
group_index <- which(cycHumanBloodDesign[, "group"] == "SleepExtension")
cycHumanBloodDesignSE <- cycHumanBloodDesign[group_index,]
sample_index <- which(cycHumanBloodDesignSE[, "subject"] == "AF0004")
sample_AF0004 <- cycHumanBloodDesignSE[sample_index, "sample_library"]
cycHumanBloodDataSE_AF0004 <- cycHumanBloodData[, c("ID_REF", sample_AF0004)]
head(cycHumanBloodDataSE_AF0004)

## ---- echo=FALSE, warning=FALSE, out.width = "640px"---------------------
knitr::include_graphics("./images/image1.png")

## ---- echo=FALSE, warning=FALSE, out.width = "640px"---------------------
knitr::include_graphics("./images/image2.png")

## ---- echo=FALSE, warning=FALSE, out.width = "640px"---------------------
knitr::include_graphics("./images/image3.png")

## ---- warning=FALSE------------------------------------------------------
# given three phases
pha <- c(0.9, 0.6, 23.6)
# their corresponding periods
per <- c(23.5, 24, 24.5)
# mean period length
per_mean <- mean(per)
# covert to polar coordinate
polar <- 2*pi*pha/per
# get averaged ploar coordinate
polar_mean <- atan2(mean(sin(polar)), mean(cos(polar)))
# get averaged phase value
pha_mean <- per_mean*polar_mean/(2*pi)
pha_mean

## ---- echo=FALSE, warning=FALSE, fig.width=6.65, fig.height=5------------
getAMP <- function(expr, per, pha, tim=18:65)
{ 
    trendt <- tim - mean(tim[!is.na(tim) & !is.nan(tim)])
    cost <- cos(2*pi/per*(tim - pha))
    fit <- lm(expr~trendt + cost)
    fitcoef <- fit$coefficients
    basev <- fitcoef[1]
    trendv <- fitcoef[2]
    ampv <- fitcoef[3]
    fitexp <- basev + trendv*trendt + ampv*cost
    outL <- list("base"=basev, "trend"=trendv, "amp"=ampv, "fit"=fitexp)
    return(outL)
}

cirD <- cycVignettesAMP
ampL <- getAMP(expr=as.numeric(cirD[1,24:71]), per=cirD[1, "meta2d_period"], pha=cirD[1, "meta2d_phase"])

lay<-layout(cbind(1, 2), widths=c( lcm(cm(4.5)), lcm(cm(1.5)) ), heights=lcm(cm(4.5)) )
par(mai=c(0.65,0.6,0.4,0.05),mgp=c(2,0.5,0),tck=-0.01)
xrange <- c(18, 65)
yrange <- c(200, 2350)
plot(18:65, cirD[1,24:71], type="b", xlim=xrange, ylim=yrange, xlab="Circadian time(CT)", ylab="Expression value",  main=cirD[1,1], cex.main=1.2)
par(new=T)
plot(18:65, ampL[[4]], type="b", xlim=xrange, ylim=yrange, col="red", xlab="", ylab="", main="")
abline(h=ampL[[1]], lty=3, col="purple", lwd=1.5)
lines(18:65, 500+ampL[[2]]*(18:65-mean(18:65)), lty=4, col="orange", lwd=1.5)
legend("topleft", legend=c("Raw value", "OLS fitted value"), col=c("black", "red"), pch=1, bty="n")
legend("topright", legend=c("Baseline", "Trend"), col=c("purple", "orange"), lty=c(3, 4), lwd=1.5, bty="n" )

par(mai=c(0.5,0.05,0.4,0.1),mgp=c(2,0.3,0),tck=-0.01);
plot(x=NULL,y=NULL,xlim=c(0,10),ylim=c(0,10),type="n", xaxt="n",yaxt="n",bty="n",xlab="",ylab="",main="")
text(rep(1,3), c(8, 5, 2), c("Base = ", "Trend = ", "AMP = "), adj=0)
text_value <- unlist(ampL)
text(rep(6,6), c(8, 5, 2), round(text_value[1:3], 1), adj=0)

## ---- echo=FALSE, warning=FALSE, fig.width=6.65, fig.height=5------------
cirD <- cycVignettesAMP
cirM <- as.matrix(cirD[2:3, 24:71])
expmax <- apply(cirM, 1, max)
cirM <- cirM/expmax

lay<-layout(cbind(1, 2), widths=c( lcm(cm(4.5)), lcm(cm(1.5)) ), heights=lcm(cm(4.5)) )
par(mai=c(0.65,0.6,0.4,0.05),mgp=c(2,0.5,0),tck=-0.01)
xrange <- c(18, 65)
yrange <- c(0, 1)
colname <- c("red", "blue")
grey_trans <- rgb(191/255,191/255,191/255,0.65);

par(mai=c(0.65,0.6,0.2,0.05),mgp=c(2,0.5,0),tck=-0.01)
plot(NULL,NULL,xlim=xrange,ylim=yrange,xaxt="n",yaxt="n",xlab="Circadian time(CT)",ylab="Exp/Max", main="");
rect_xL <- c(18, 36, 60)
rect_yL <- c(24, 48, 65)
rect(rect_xL, rep(-0.1, 3), rect_yL, rep(1.1,3), col=grey_trans, border=NA, bty="n")

for (i in 1:2)
{
  loessD <- data.frame(expd=as.numeric(cirM[i,]),tp=18:65);
  exploess <- loess(expd~tp, loessD, span = 0.2);
  expsmooth <- predict(exploess, data.frame(tp=18:65));
  lines(18:65,expsmooth,lwd=1.2,col=colname[i]);
}

xpos <- c(seq(18,60,by=6), 65)
axis(side=1,at=xpos,labels=xpos,mgp=c(0,0.2,0),tck=-0.01,cex.axis=0.8)
ypos <- seq(0, 1, by=0.2)
axis(side=2,at=ypos,labels=ypos,mgp=c(0,0.2,0),tck=-0.01,cex.axis=0.8)

par(mai=c(0.5,0.05,0.2,0.1),mgp=c(2,0.3,0),tck=-0.01)
plot(x=NULL,y=NULL,xlim=c(0,10),ylim=c(0,10),type="n", xaxt="n",yaxt="n",bty="n",xlab="",ylab="",main="")
lines(c(0.2,2.3), c(9.5,9.5), col="blue", lwd=1.5)
text(c(5,0,0), c(9.5, 8, 6.5), c("Ugt2b34", "AMP = ", "rAMP = "), col="blue", adj=0)
text(c(5,5), c(8, 6.5), round(as.numeric(cirD[3, 22:23]), 2), col="blue", adj=0)

lines(c(0.2,2.3), c(4.5,4.5), col="red", lwd=1.5)
text(c(5,0,0), c(4.5, 3, 1.5), c("Arntl", "AMP = ", "rAMP = "), col="red", adj=0)
text(c(5,5), c(3,1.5), round(as.numeric(cirD[2, 22:23]), 2), col="red", adj=0)

