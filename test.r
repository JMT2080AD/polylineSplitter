library(sp)
library(magrittr)
source("./polylineSplitter.r")

## basic line splitting
x <- c(0.549, 0.707, 1.044, 1.652, 2.530, 2.890, 3.520, 4.218, 4.781, 4.848, 4.893, 4.893, 4.848, 5.006, 5.951, 6.289, 7.077, 7.909, 8.967)  
y <- c(0.667, 1.474, 2.778, 3.063, 4.131, 4.582, 5.341, 5.412, 5.460, 5.554, 5.673, 5.863, 6.029, 6.100, 6.622, 7.168, 7.476, 7.453, 7.500)

ldat <- Line(data.frame(x,y)) %>%
    list() %>%
    Lines(ID = 1) %>%
    list() %>%
    SpatialLines()

ldatSplit <- splitLines(ldat, 3)

png("./images/line_splitting.png")
par(mfrow = c(1,2))
plot(ldat, col = rainbow(length(ldat)), main = "Original Line", lwd = 2)
plot(ldatSplit, col = rainbow(nrow(ldatSplit)), main = "Split Line", lwd = 2)
dev.off()

## polygon applications
x <- c(1.518, 1.908, 3.452, 5.562, 6.968, 7.965, 8.043, 6.949, 5.542, 4.800, 4.644, 4.409, 4.116, 3.823, 3.471, 3.217, 3.022, 2.495, 2.026, 1.889, 1.518, 1.479, 1.420)
y <- c(4.594, 6.295, 7.233, 7.800, 6.338, 5.226, 3.721, 2.020, 2.042, 2.478, 2.980, 3.481, 3.743, 3.808, 3.896, 3.939, 3.896, 3.743, 3.678, 3.787, 3.918, 4.157, 4.288)                       

pdat <- Polygon(data.frame(x,y)) %>%
    list() %>%
    Polygons(ID = 1) %>%
    list() %>%
    SpatialPolygons()

## sample intervals
pdatSplit <- splitPoints(as(pdat, "SpatialLines"), 1)

png("./images/polygon_sampling.png")
par(mfrow = c(1,2))
plot(pdat, col = rainbow(length(pdat)), main = "Original Polygon", lwd = 2)
plot(pdatSplit, col = rainbow(length(pdatSplit)), main = "Sampled Along Polygon Edge\nAt Even Intevals", lwd = 2)
dev.off()

## polygon simplification
pdatSplit <- splitPoints(as(pdat, "SpatialLines"), 1)

pdatSimp <- Polygon(pdatSplit@coords) %>%
    list() %>%
    Polygons(ID = 1) %>%
    list() %>%
    SpatialPolygons()

png("./images/polygon_simplification.png")
par(mfrow = c(1,2))
plot(pdat, col = rainbow(length(pdat)), main = "Original Polygon", lwd = 2)
plot(pdatSimp, col = rainbow(length(pdatSimp)), main = "Simplified Polygon via Line Splitting", lwd = 2)
dev.off()