#########**************** R FOR COMP BIO **************###################

### LAB STEP # 3: here is the number of chips we have, (5 bags of flaming hot cheetos -ew)
bag_o_chip <- 5
### I have eight guests on the list
num_guest <- 8
### LAB STEP # 5: each guest will probably eat like .4 bags of chips... i guess
avg_eat_chip <- .4
### how many bags of chips will we eat (including myself)
bag_o_chip - ((num_guest * avg_eat_chip) + .4)
### we will have 1.4 bags of Hot Cheetos left

### NOW WE RANK ALL THE MOVIEEEESSSS (I-IV of Starwars)
Self <- c(7,6,5,1,2,3,4)
Penny <- c(5,7,6,3,1,2,4)
Jenny <- c(4,3,2,7,6,5,1)
Lenny <- c(1,7,3,4,6,5,2)
Stewie <- c(6,7,5,4,3,1,2)

### What is Penny's rank for movie IV?
PennyIV <- Penny[4]
### What is Lenny's rank for movie IV?
LennyIV <- Lenny[4]

### STEP 10 Make a matrix of all of the 5 sets of rankings
RANKING <- cbind(Self, Penny, Jenny, Lenny, Stewie)
### STEP 11 Check the sturcture of Penny, PennyIV, and RANKING
str(Penny)
str(PennyIV)
str(RANKING)
### the structure of Penny is a vector of 7 variables
### the structure of PennyIV is just a stored variable of one, the number 3
### the structure of RANKING is a matrix with 7 rows and 5 columns

### STEP 12 make RANKING into a data frame (practive by using both as.data.frame and data.frame)
DATA_FRAME_RANK1 <- as.data.frame(RANKING)
## as.data.frame will take a matrix but not vectors
DATA_FRAME_RANK2 <- data.frame(Self, Penny, Jenny, Lenny, Stewie)
## data.frame expects vectors but not matrices

## STEP 13 - compare the Matrix made by cbind and the data frame created in step 12
str(DATA_FRAME_RANK1) ; dim(DATA_FRAME_RANK1) ; typeof(DATA_FRAME_RANK1)
## called data frame, with 7 objects and 5 variables with the dimensions 7 and 5, is also called a list
RANKING == DATA_FRAME_RANK1
str(RANKING) ; dim(RANKING) ; typeof(RANKING)
## Also called lists, but not called data frame
## Both contain all the same variables

### STEP 14 make a vector of the episode names!
Ep_names <- c("I", "II", "III", "IV", "V", "VI", "VII")

### Step 15 add this vector to name the row headings from step 10 AND 12 and inspect them to make sure it happened!
?row.names
row.names(RANKING) <- Ep_names

row.names(DATA_FRAME_RANK1) <- Ep_names
row.names(DATA_FRAME_RANK2) <- Ep_names

RANKING
DATA_FRAME_RANK1
DATA_FRAME_RANK2

### NOTES: for data frames and matrices, row specification always first, column always second

### STEP 16 acess the third row of the matrix from step 10 (RANKING)
RANKING[3,]

### STEP 17 access the fourth column of data frame from step 12
DATA_FRAME_RANK1[,4]

### STEP 18 access ranking for episode V
RANKING[4,]

### STEP 19 access Penny's ranking for episode II
RANKING[2,2]

### STEP 20 everyones ranking from episodes IV-VI (Four-six)
RANKING[4:6,]

### STEP 21 everyone's ranking from II, V and VII (2,5,7)
RANKING[c(2,5,7),]
RANKING[c("II","V","VII"),]

### STEP 22 ranks from just Penny, Jenny, and Stewie for ep IV and VI
RANKING[c("IV","VI"), c("Penny","Jenny", "Stewie")]

### STEP 23 Switch Lenny's rankings for II and V
Lennyold2 <- RANKING["II", "Lenny"]
RANKING["II", "Lenny"] <- 6
RANKING["V", "Lenny"] <- Lennyold2
RANKING

### STEP 24 - trying with matrix/data frame names with Penny and III
RANKING["III", "Penny"]
DATA_FRAME_RANK1["III", "Penny"]

### STEP 25 use the methods in step 24 to undo step 23
Lennyold_old2 <- RANKING["II", "Lenny"]
RANKING["II", "Lenny"] <- 7
RANKING["V", "Lenny"] <- Lennyold_old2
RANKING == DATA_FRAME_RANK1

### STEP 26 re-switch Lenny's ranking for II and V using the $ method and the data frame
LENOLD2 <- DATA_FRAME_RANK1$Lenny[2]
DATA_FRAME_RANK1$Lenny[5] <- LENOLD2
DATA_FRAME_RANK1$Lenny[2] <- 6
DATA_FRAME_RANK1

