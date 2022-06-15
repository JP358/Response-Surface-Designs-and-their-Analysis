
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

# Model summary
summary(yield_model)

# Export summary
capture.output(
  summary(yield_model),           # Object to be exported
  file = "data/model_summary.txt" # File name 
)