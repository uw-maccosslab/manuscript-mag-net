getCV = function(df){
  calCV <- function(x){
    (sd(x, na.rm = T)/mean(x, na.rm = T))
  }
  cv = apply(df, 1, function (x) calCV(x))
  return(cv)
}