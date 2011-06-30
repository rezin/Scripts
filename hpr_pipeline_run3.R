#######################################
# Rezin Dilshad
# 2011-02-23
# Description: The script count Pearson correlation between
# Rpkm for different samples
#######################################


###################################
# Cufflinks pipeline
##################################

setwd("/Users/rezdil/Documents/RNAseq/HPRsamples/run3")
#gene, transcript, rpkm, readcount

a1  <-  read.table("cufflinks_htseq_A1_9_1.expr", sep = "\t", header = T)
b1  <- read.table("cufflinks_htseq_B1_10_1.expr", sep = "\t", header = T)
a2  <-  read.table("cufflinks_htseq_A2_3_1.expr", sep = "\t", header = T)
b2  <- read.table("cufflinks_htseq_B2_4_1.expr", sep = "\t", header = T)
a3  <-  read.table("cufflinks_htseq_A3_lane6.expr", sep = "\t", header = T)
b3  <- read.table("cufflinks_htseq_B3_lane7.expr", sep = "\t", header = T)


hprNames <- c("list of names")

noHpr <- 6

hprList <- list (a1,b1,a2,b2,a3,b3)
corr_matrix <- matrix (0,nrow=noHpr,ncol=noHpr)
count <- matrix (0,nrow=noHpr,ncol=4)

head(a1)
head(hprList[[1]]$Htseq_readCount)

#order(hprList[[1]]$Htseq_readCount)

#######################################
# CORRELATION OF READCOUNT
# Sort by V4
#######################################
for(i in 1:noHpr){
	for (j in 1:noHpr){
		order_i <- hprList[[i]][order(hprList[[i]]$Htseq_readCount),]
		order_j <- hprList[[j]][order(hprList[[j]]$Htseq_readCount),]
    corr_matrix [i,j]  <- cor(order_i$Htseq_readCount,order_j$Htseq_readCount)
		print (cor(order_i$Htseq_readCount,order_j$Htseq_readCount))
		}
		count[i,1] <- min(hprList[[i]]$Htseq_readCount)
		count[i,2] <- mean(hprList[[i]]$Htseq_readCount)
		count[i,3] <- median(hprList[[i]]$Htseq_readCount)
		count[i,4] <- max(hprList[[i]]$Htseq_readCount)
	}
warnings ()

#cor_readCount <- data.frame(corr_matrix)
names(cor_readCount) <- hprNames
row.names(cor_readCount) <- hprNames

write.table(cor_readCount,"cor_readCount_hpr.csv", sep="\t", row.names = TRUE, col.names=TRUE)
pdf("heatmap_corReadCount.pdf")
library(gplots)
heatmap.2(as.matrix(cor_readCount),trace="none")
dev.off()

#######################################
# CORRELATION OF RPKM
# Sort by V3
#######################################

cor_rpkm <- matrix (0,nrow=noHpr,ncol=noHpr)
freq <- matrix (0,nrow=noHpr,ncol=4)
for(i in 1:noHpr){
	for (j in 1:noHpr){
		order_i <- hprList[[i]][order(hprList[[i]]$FPKM),]
		order_j <- hprList[[j]][order(hprList[[j]]$FPKM),]
		cor_rpkm [i,j]  <- round(cor(order_i$FPKM,order_j$FPKM,method = "kendall"),3)
    print (cor(order_i$FPKM,order_j$FPKM))
		}
		freq[i,1] <- min(hprList[[i]]$FPKM)
		freq[i,2] <- mean(hprList[[i]]$FPKM)
		freq[i,3] <- median(hprList[[i]]$FPKM)
		freq[i,4] <- max(hprList[[i]]$FPKM)
	}

#####
# TEST 2011-06-08
tmp <- hprList[[1]][order(hprList[[1]]$FPKM),]
head(hprList[[1]])
head(tmp)

tmp3 <- hprList[[3]][order(hprList[[3]]$FPKM),]
head(hprList[[3]])
head(tmp3)

cor(tmp$FPKM,tmp3$FPKM)


######

cor_rpkm <- data.frame(cor_rpkm)

names(cor_rpkm) <- c("list of names")
row.names(cor_rpkm) <- c("list of names")

write.table(cor_rpkm,"cor_fpkm_run3.csv", sep="\t", row.names = TRUE, col.names=TRUE)


freq_data <- data.frame(count,freq)
names(freq_data) <- c("Count_min","Count_mean","Count_median","Count_max","RPKM_min","RPKM_mean","RPKM_median","RPKM_max")
row.names(freq_data) <- c("list of names")

library(gplots)
pdf("heatmap_corFPKM.pdf")
heatmap.2(as.matrix(cor_rpkm),trace="none",cellnote=as.matrix(cor_rpkm),notecol="black",notecex=0.7)


library(gplots)
#heatmap.2(as.matrix(cor_rpkm),trace="none")
dev.off()

