data <- data.frame(
  Name = c("John", "Alice", "Bob", "Carol", "Josiah", "Candace", "Paswel", "Alemnesh", "Yohannes", "Hanna", "Olaf", "Yuki"),
  Age = sample(seq(21,58,1),12, replace=TRUE),
  Gender = c("Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female"),
  ScoreA1 = round(rnorm(12, mean=81, sd=10)),
  ScoreB1 = round(rnorm(12, mean=81, sd=10)),
  ScoreC1 = round(rnorm(12, mean=81, sd=10)),
  ScoreD1 = round(rnorm(12, mean=81, sd=10)),
  ScoreE1 = round(rnorm(12, mean=81, sd=10)),
  ScoreA2 = round(rnorm(12, mean=81, sd=10)),
  ScoreB2 = round(rnorm(12, mean=81, sd=10)),
  ScoreC2 = round(rnorm(12, mean=81, sd=10)),
  ScoreD2 = round(rnorm(12, mean=81, sd=10)),
  ScoreE2 = round(rnorm(12, mean=81, sd=10)),
  ScoreA3 = round(rnorm(12, mean=81, sd=10)),
  ScoreB3 = round(rnorm(12, mean=81, sd=10)),
  ScoreC3 = round(rnorm(12, mean=81, sd=10)),
  ScoreD3 = round(rnorm(12, mean=81, sd=10)),
  ScoreE3 = round(rnorm(12, mean=81, sd=10))
)

#mylist <- c("A","B","C","D","E")

mylist <- colnames(data)
mylist_short <- c("ScoreA", "ScoreB", "ScoreC", "ScoreD", "ScoreE")
names(mylist_short) <- c("Score A", "Score B", "Score C", "Score D", "Score E")

x <- mylist_short[c(2,3)]



