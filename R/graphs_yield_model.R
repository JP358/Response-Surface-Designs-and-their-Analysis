
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

# Contour plots
par(mfrow = c(2,3))       # 2 x 3 pictures on one plot
contour(
  yield_model,            # Our model
  ~ x1 + x2 + x3 + x4,    # A formula to obtain the 6 possible graphs 
  image = TRUE,           # If image = TRUE, apply color to each contour
)

# Save contour plot
jpeg(
  filename = "graphs/model_contours.jpeg", width = 30, height = 20, 
  units = "cm", res = 400, quality = 100
)
par(mfrow = c(2,3))       # 2 x 3 pictures on one plot
contour(
  yield_model,            # Our model
  ~ x1 + x2 + x3 + x4,    # A formula to obtain the 6 possible graphs 
  image = TRUE,           # If image = TRUE, apply color to each contour
)
dev.off()

# 3D plots
par(mfrow = c(2,3))       # 2 x 3 pictures on one plot
persp(
  yield_model,            # Our model 
  ~ x1 + x2 + x3 + x4,    # A formula to obtain the 6 possible graphs
  col = topo.colors(100), # Color palette
  contours = "colors"     # Include contours with the same color palette
) 

# Save 3D plots
jpeg(
  filename = "graphs/model_3D.jpeg", width = 30, height = 20, 
  units = "cm", res = 400, quality = 100
)
par(mfrow = c(2,3))       # 2 x 3 pictures on one plot
persp(
  yield_model,            # Our model 
  ~ x1 + x2 + x3 + x4,    # A formula to obtain the 6 possible graphs
  col = topo.colors(100), # Color palette
  contours = "colors"     # Include contours with the same color palette
) 
dev.off()