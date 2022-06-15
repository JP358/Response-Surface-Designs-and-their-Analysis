
# Example analysis with yield data ----------------------------------------

library(rsm)

# Import data
yield_data <- readr::read_csv("data/yield_data.csv")

head(yield_data)

# Coded units
yield_data <- coded.data(
  yield_data,                 # Experimental data
  formulas = list(            # List of coding formulas for each factor
    x1 ~ (A - 210)/30, 
    x2 ~ (B - 80)/10,
    x3 ~ (C - 30)/15,
    x4 ~ (D - 30)/10
  ))

head(yield_data)


# Adjust a second order model
yield_model <- rsm(Yield ~ SO(x1, x2, x3, x4), data = yield_data)

# Optimal point in coded units
opt_point <- summary(yield_model)$canonical$xs
opt_point

# Optimal point in original units
op_point_ru <- code2val(
  opt_point,                     # Optimal point in coded units
  codings = codings(yield_data)  # Formulas to convert to factor units
)
op_point_ru

# Predict best response
opt_point_df <- data.frame(  # predict() needs a data frame with the points 
  x1 = opt_point[1],         # to be predicted 
  x2 = opt_point[2],
  x3 = opt_point[3],
  x4 = opt_point[4]
)

best_response <- predict(
  yield_model,             # Our model
  opt_point_df             # Data frame with points to be predicted 
)
names(best_response) <- "Best yield" # A nice name to our best point
best_response