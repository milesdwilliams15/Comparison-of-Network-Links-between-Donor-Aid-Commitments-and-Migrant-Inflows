
# ------------------------------------------------
# Network Analysis of Bilateral Migrant Inflows 
# and Bilateral Aid Commitments into OECD Member 
# Countries
# ------------------------------------------------
library(Hmisc)
library(corrplot)
library(ggplot2)
library(igraph)
library(ggraph)
library(dplyr)
library(grid)
library(gridExtra)

# ------------------------------------------------
# Immigration

# Get the data
path <- file.path("C:","Users","Miles","Documents","R",
                  "Network Analysis of Foreign Aid","img.csv")
img <- read.csv(path)

# Get correlations
res<-rcorr(as.matrix(img))
windows()
par(family="serif")
corrplot(res$r,type="upper",order="hclust",tl.col="black",tl.pos="d",
         tl.cex=.75,p.mat=res$P,sig.level=0.05,
         title="Correlations between OECD Member Bilateral\nMigrant Inflows",
         mar=c(2,2,3,2))
mtext("ThePoliticalScientist1.blogspot.com",side=1,adj=0,line=3,cex=.75)

# Put correlations in pairwise format along with p-values
res.r <- res$r
res.r[lower.tri(res.r,diag=TRUE)]=NA # put NA
res.r<-as.data.frame(as.table(res.r)) # as a dataframe
res.r<-na.omit(res.r) # remove NA
res.r$r <- res.r$Freq
res.r <- res.r[,-3]
res.p <- res$P
res.p[lower.tri(res.p,diag=TRUE)]=NA # put NA
res.p<-as.data.frame(as.table(res.p)) # as a dataframe
res.p<-na.omit(res.p) # remove NA
res.p$p<-res.p$Freq
res.p <- res.p[,-3]
res1 <- cbind(res.r,res.p[,3])
res1$p <- res1$`res.p[, 3]`
res1 <- res1[,-4]

# Convert res into a csv file and add bilateral distance to the dataset
write.csv(res1,"C:/Users/Miles/Documents/R/Network Analysis of Foreign Aid/resImg.csv")

# Plot the network of correlations
set.seed(123)
windows()
g <- res1 %>% filter(r >= mean(r)) %>%
  graph_from_data_frame() %>% 
  ggraph(layout = "fr") + 
  geom_edge_arc(aes(edge_alpha = r, edge_width = r), 
                edge_colour = "red",curvature = .5,
                lineend = "round",linejoin = "round") +
  geom_node_point(alpha = 0) +
  geom_node_text(aes(label = name), repel = FALSE,
                 point.padding = unit(0.2, "lines")) +
  theme_void() + theme(text=element_text(family="serif")) +
  ggtitle("\nNetwork of Pairwise Correlations between\nOECD Members' Bilateral Migrant Inflows\nfrom Non-Member States") +
  theme(plot.title=element_text(face="bold",size=14,hjust=.5)) +
  theme(legend.position = "bottom")
g <- arrangeGrob(g, bottom = textGrob("ThePoliticalScientist1.blogspot.com", x = .01, hjust = 0, vjust=0.1, gp = gpar(fontsize = 10,fontfamily="serif",
                                                                                                                      face="bold")))
grid.draw(g)

# ----------------------------------------------------
# Aid Commitments
# Get the data
path <- file.path("C:","Users","Miles","Documents","R",
                  "Network Analysis of Foreign Aid","aid.csv")
aid <- read.csv(path)

# Get correlations
res<-rcorr(as.matrix(aid))
windows()
par(family="serif")
corrplot(res$r,type="upper",order="hclust",tl.col="black",tl.pos="d",
         tl.cex=.75,p.mat=res$P,sig.level=0.05,
         title="Correlations between OECD Member Bilateral\nAid Commitments",
         mar=c(2,2,3,2))
mtext("ThePoliticalScientist1.blogspot.com",side=1,adj=0,line=3,cex=.75)

# Put correlations in pairwise format along with p-values
res.r <- res$r
res.r[lower.tri(res.r,diag=TRUE)]=NA # put NA
res.r<-as.data.frame(as.table(res.r)) # as a dataframe
res.r<-na.omit(res.r) # remove NA
res.r$r <- res.r$Freq
res.r <- res.r[,-3]
res.p <- res$P
res.p[lower.tri(res.p,diag=TRUE)]=NA # put NA
res.p<-as.data.frame(as.table(res.p)) # as a dataframe
res.p<-na.omit(res.p) # remove NA
res.p$p<-res.p$Freq
res.p <- res.p[,-3]
res2 <- cbind(res.r,res.p[,3])
res2$p <- res2$`res.p[, 3]`
res2 <- res2[,-4]

# Convert res into a csv file and add bilateral distance to the dataset
write.csv(res2,"C:/Users/Miles/Documents/R/Network Analysis of Foreign Aid/resAid.csv")

# Plot the network of correlations
set.seed(1234)
windows()
g <- res.r %>% filter(Correlation >= mean(Correlation)) %>%
  graph_from_data_frame() %>%
  ggraph(layout = "fr") + 
  geom_edge_arc(aes(edge_alpha = Correlation, edge_width = Correlation), 
                edge_colour = "blue",curvature = .5,
                lineend = "round",linejoin = "round") +
  geom_node_point(alpha = 0) +
  geom_node_text(aes(label = name), repel = FALSE,
                 point.padding = unit(0.2, "lines")) +
  theme_void() + theme(text=element_text(family="serif")) +
  ggtitle("\nNetwork of Pairwise Correlations between\nOECD Members' Bilateral Aid Commitments\nto Non-Member States") +
  theme(plot.title=element_text(face="bold",size=14,hjust=.5)) +
  theme(legend.position = "bottom")
g <- arrangeGrob(g, bottom = textGrob("ThePoliticalScientist1.blogspot.com", x = .01, hjust = 0, vjust=0.1, gp = gpar(fontsize = 10,fontfamily="serif",
                                                                                                                      face="bold")))
grid.draw(g)

# --------------------------------------------------
# Analysis of Correlation between Donors' Aid
# Commitments and Migrant Inflows
# --------------------------------------------------
path <- file.path("C:","Users","Miles","Documents","R",
                  "Network Analysis of Foreign Aid","dist.csv")
dist <- read.csv(path)
dist$p_aid <- res2$p
dist$p_inflows <- res1$p

m1 <- lm(r_aid ~ distance, data=dist)
library(scales)
windows()
ggplot(dist,aes(x=distance,y=r_aid)) + geom_point(alpha=0) +
  geom_smooth(method="loess") + 
  geom_abline(intercept = m1$coefficients[1], slope = m1$coefficients[2], 
              color = "red", linetype = 2, size=1) +
  theme_minimal() +
  theme(text=element_text(family="serif")) +
  geom_text(aes(label=paste(as.character(dist[,1]),"-",as.character(dist[,2]))),
            size=3,family="serif") +
  xlab("Weighted Bilateral Distance in Kilometers") + 
  ylab("Pairwise Correlation between Country's Bilateral Aid Commitments") +
  ggtitle("Variation in Pairwise Correlations as a Function of Bilateral Distance") +
  theme(plot.title=element_text(size=16,face="bold")) +
  annotate("text",x=16500,y=.55,
           label="Adjusted~R^{2}==0.20",parse=TRUE,family="serif",
           hjust=0) +
  annotate("text",x=16500,y=.6,
           label="beta[0]==0.27",parse=TRUE,family="serif",
           hjust=0) +
  annotate("text",x=16500,y=.575,
           label="beta[1]==-1.051e-05",parse=TRUE,family="serif",
           hjust=0) +
  scale_x_continuous(labels=comma)