# MagNet Particle Enrichment Manuscript figures

#Required packages
#library(dplyr, quietly = T)
#library(ggplot2, quietly = T)
#library(tidyr, quietly = T)
#library(ggrepel, quietly = T)


#### Figure 3c ####
## Particle distribution plot

#Read in data
size.df <- read.csv("Sample 14-Particle Distribution.csv", stringsAsFactors = FALSE)

#Re-naming the columns just for ease of processing
names <- c(size="Particle.Size..nm.", mean="Concentration.Average..particles...ml.", sd="Stdev")
size.df <- rename(size.df, all_of(names))

#plot but with more axis tick marks
ggplot(size.df, aes(x=size, y=mean))+
  geom_line(color="midnightblue")+
  geom_ribbon(aes(y=mean, ymin=mean-sd, ymax=mean+sd), alpha=.4) +
  scale_y_continuous(labels=function(x) format(x, scientific = TRUE), breaks=pretty(size.df$mean, n=7))+
  scale_x_continuous(breaks=pretty(size.df$size, n=9))+
  labs(y="mean concentration (particles/ml)", x="size (nm)")+
  theme_bw()



#### Figure 4a & 4b ####
### Dynamic range plots

#Read in data
prot.df <- read.csv("EV and Plasma Protein Total Areas.csv", stringsAsFactors = FALSE)

#separating the ev enrichment vs plasma 
ev.prot <- prot.df %>% dplyr::select(contains("SAXN"))
pl.prot <- prot.df %>% dplyr::select(contains("HydN"))

#Adding back the protein info 
ev.prot <- cbind(prot.df[,1:3], ev.prot)
pl.prot <- cbind(prot.df[,1:3], pl.prot)

#Mean and rank added columns
ev.prot$Mean <- rowMeans(ev.prot[,4:ncol(ev.prot)], na.rm=TRUE)
pl.prot$Mean <- rowMeans(pl.prot[,4:ncol(pl.prot)], na.rm=TRUE)
ev.prot$Rank <- rank(-ev.prot$Mean)
pl.prot$Rank <- rank(-pl.prot$Mean)


#EV marker list
evm <- c('CD9','CD63','PDCD6IP','FLOT1','FLOT2','TSG101','SDCBP','NCAM1','CD40','SEPTIN2','ATP5F1A','HSP90B1','ANXA5')

#Abundant Plasma marker list
plm <- c('ALB','TF','A2M','SERPINA1','ORM1','HP','APOA1','APOA2','APOB','APOC1','APOD','HBA2','HBB')

#all markers
m <- c(evm, plm)


#Just enriched particle samples:
#Extracting just markers (separately for adding IDs)
ev.evm <- data.frame(ev.prot[ev.prot$ProteinGene %in% evm,])
ev.plm <- data.frame(ev.prot[ev.prot$ProteinGene %in% plm,])

#Adding marker identifier
ev.evm$Marker <- "EV"
ev.plm$Marker <- "Plasma"

#Identifying non-marker proteins
non.em <- data.frame(ev.prot[!ev.prot$ProteinGene %in% m,])
non.em$Marker <- "none"

#combining everything back together
ev.mark <- rbind(ev.evm, ev.plm, non.em)


#Just whole plasma samples:
#Extracting just markers (separately for adding IDs)
pl.evm <- data.frame(pl.prot[pl.prot$ProteinGene %in% evm,])
pl.plm <- data.frame(pl.prot[pl.prot$ProteinGene %in% plm,])

#Adding marker identifier
pl.evm$Marker <- "EV"
pl.plm$Marker <- "Plasma"

#Identifying non-marker proteins
non.pm <- data.frame(pl.prot[!pl.prot$ProteinGene %in% m,])
non.pm$Marker <- "none"

#combining everything back together
pl.mark <- rbind(pl.evm, pl.plm, non.pm)


# Figure 4a
range_pl <- ggplot(pl.mark, aes(x=Rank, y=log10(Mean), fill=Marker, color=Marker)) +
  geom_point(alpha=0.5) +
  scale_color_manual(values=c("EV"="blue", "Plasma"="red2", "none"="grey40")) + 
  geom_label_repel(data=filter(pl.mark, Marker=="EV"), 
                   aes(label=ProteinGene),
                   fontface='bold',
                   fill="mediumblue",
                   color="white",
                   size=4,
                   max.overlaps=(getOption("ggrepel.max.overlaps", default=20)),
                   min.segment.length = 0.2,
                   segment.color = 'grey30') +
  geom_label_repel(data=filter(pl.mark, Marker=="Plasma"), 
                   aes(label=ProteinGene),
                   fontface='bold',
                   fill="red2",
                   color="white",
                   size=4,
                   max.overlaps=(getOption("ggrepel.max.overlaps", default=20)),
                   min.segment.length = 0.2,
                   segment.color = 'grey30') + 
  geom_point(data=filter(pl.mark, Marker=="Plasma"), 
             aes(x=Rank, y=log10(Mean)), color="red2") +
  geom_point(data=filter(pl.mark, Marker=="EV"), 
             aes(x=Rank, y=log10(Mean)), color="blue") +
  scale_y_continuous(limits=c(2, 12.5)) +
  theme_bw() +
  theme(legend.position="none")
range_pl

#Insets of rank 1-400 generated from same code, but with + scale_x_continuous(limits=c(1,400))
#labels manually adjusted in pdf


# Figure 4b
range_EV <- ggplot(ev.mark, aes(x=Rank, y=log10(Mean), fill=Marker, color=Marker)) +
  geom_point(alpha=0.5) +
  scale_color_manual(values=c("EV"="blue", "Plasma"="red2", "none"="grey40")) + 
  geom_label_repel(data=filter(ev.mark, Marker=="EV"), 
                   aes(label=ProteinGene),
                   fontface='bold',
                   fill="mediumblue",
                   color="white",
                   size=4,
                   max.overlaps=(getOption("ggrepel.max.overlaps", default=20)),
                   min.segment.length = 0.2,
                   segment.color = 'grey30') +
  geom_label_repel(data=filter(ev.mark, Marker=="Plasma"), 
                   aes(label=ProteinGene),
                   fontface='bold',
                   fill="red2",
                   color="white",
                   size=4,
                   max.overlaps=(getOption("ggrepel.max.overlaps", default=20)),
                   min.segment.length = 0.2,
                   segment.color = 'grey30') +
  geom_point(data=filter(ev.mark, Marker=="Plasma"), 
             aes(x=Rank, y=log10(Mean)), color="red2") +
  geom_point(data=filter(ev.mark, Marker=="EV"), 
             aes(x=Rank, y=log10(Mean)), color="blue") +
  scale_y_continuous(limits=c(2, 12.5)) +
  theme_bw() +
  theme(legend.position="none")
range_EV

#Insets of rank 1-400 generated from same code, but with + scale_x_continuous(limits=c(1,400))
#labels manually adjusted in pdf


