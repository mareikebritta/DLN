# R session 1 by Murray
# Contents from R for Data Science

install.packages(c('nycflights13', 'gapminder', 'Lahman'))

library(tidyverse)

tidyverse_update()

mpg

# Mapping = aesthetics, i.e. where the data should be placed
# geom_* = how the data mapping should be displayed

ggplot(data = mpg) +
	geom_point(mapping = aes(x = class, y = drv))

# Colour based on class
ggplot(data = mpg) +
	geom_point(mapping = aes(x = displ, y = hwy, color = class))

# Transparency based on class
ggplot(data = mpg) +
	geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# Specify certain aspects of the plot (e.g. colour)
ggplot(data = mpg) +
	geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

ggplot(mpg) +
	geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5 & hwy < 30))

# Facet the combinations and use only 2 rows in the plot:
ggplot(mpg) +
	geom_point(mapping = aes(x = displ, y = hwy)) +
	facet_wrap( ~ class, nrow = 2)

# facet_grid automatically make grids based on the variables you give:
# facet_wrap("ROW" ~ "COLUMN")
ggplot(mpg) +
	geom_point(mapping = aes(x = displ, y = hwy)) +
	facet_grid( . ~ class)

ggplot(mpg) +
	geom_point(mapping = aes(x = displ, y = hwy)) +
	facet_grid( class ~ . )

ggplot(mpg) +
	geom_point(mapping = aes(x = displ, y = hwy)) +
	facet_grid( drv ~ class)

# Scale the axis based on the values in the actual plot:
ggplot(mpg) +
	geom_point(mapping = aes(x = displ, y = hwy)) +
	facet_grid( drv ~ cyl, scales = 'free_x' )

ggplot(mpg) +
	geom_point(mapping = aes(x = displ, y = hwy)) +
	facet_grid( drv ~ cyl, scales = 'free_y' )

# Both x and y
ggplot(mpg) +
	geom_point(mapping = aes(x = displ, y = hwy)) +
	facet_grid( drv ~ cyl, scales = 'free' )

# Line graph:
ggplot(mpg) +
	geom_line(mapping = aes(x = displ, y = hwy))

# Smooth line graph:
ggplot(mpg) +
	geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# Adding plots as layers:
ggplot(mpg) +
	geom_point(mapping = aes(x = displ, y = hwy, colour = drv)) +
	geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, colour = drv))

# To remove code replication, add the aes in the first ggplot function:
ggplot(mpg, mapping = aes(x = displ, y = hwy, colour = drv)) +
	geom_point() +
	geom_smooth(mapping = aes(linetype = drv), se = F) # se = F removes the standard error

################################################################################

# ggplot automatically does some data transforming, if not in the form for
# plotting:
ggplot(data = diamonds) +
	geom_bar(mapping = aes(x = cut))

dia_cut = diamonds %>% group_by(cut) %>% count

# stat = 'identity' to prevent any transformation:
ggplot(data = dia_cut) +
	geom_bar(mapping = aes(x = cut, y = n), stat = 'identity')

# calculate proportion on the fly:
ggplot(data = diamonds) +
	geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

# By default, it will colour the border:
ggplot(data = diamonds) +
	geom_bar(mapping = aes(x = cut, colour = cut))

# use 'fill' to fill it in:
ggplot(data = diamonds) +
	geom_bar(mapping = aes(x = cut, fill = cut))

# colour how many things make up the bar:
ggplot(data = diamonds) +
	geom_bar(mapping = aes(x = cut, fill = clarity))

# Normalise the bars:
ggplot(data = diamonds) +
	geom_bar(mapping = aes(x = cut, fill = clarity), position = 'fill')

# prevent overlapping of the bars:
ggplot(data = diamonds) +
	geom_bar(mapping = aes(x = cut, fill = clarity), position = 'dodge')

# add jitter 'noise' so the points don't overlap:
ggplot(data = mpg, mapping = aes(x = drv, y = cyl)) +
	geom_point(position = 'jitter')

# without jitter:
ggplot(data = mpg, mapping = aes(x = drv, y = cyl)) +
	geom_point()

# change the coordinate system:
ggplot(data = diamonds) +
	geom_bar(mapping = aes(x = cut, fill = clarity), position = 'dodge') +
	coord_flip()

################################################################################

# R for Data Science - Chapters 4 and 5

################################################################################

# What to cover:
# 1. Functions and variables
# 2. Data manipulation with Tidyverse

# Load required libraries:
library(nycflights13)
library(tidyverse)

# Data we're going to be using in this lesson:
flights

################################################################################
# Basics of tidyverse data manipulation
#
# Five basic commands to learn:
# 1. filter() observations by their values
# 2. arrange() and reorder rows
# 3. select() variables in data frames by names
# 4. mutate() (or change) the values of the variables
# 5. summarise() the values down
#
# Grammar of tidyverse:
#
# Data goes in, function manipulates it, and you get an output
#
#         DATA %>% FUNCTION ( %>% OUTPUT )
#
################################################################################

# Get data from day 1 and month 1 (i.e. 1st of Jan), using the
# filter() function

# Note that this isn't saved, so store it in a variable:

# Wrap everything in parantheses to store AND print the output:

# Beware of double/floating point comparisons (e.g. sqrt(2) ^ 2 == 2)

# select() will use "AND" operation by default - construct your
# own logical expression for "OR" operation
#
# Get data from Nov or Dec:

# You can use the "%in%" operation to get the same result:

# filter() function excludes all FALSE and NA values from the data, so if you
# want to keep NA values in your data, you have to explivitly specify for it
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)

# Exercises

################################################################################

# arrange() function reorders the rows based on the values of the specified column(s)

# arrange() by year, then by month, and then by day:

# Use desc() to order the rows with the values descending (i.e. hight to low):

# Exercises

################################################################################

# Use select() the variables/columns that you are actually interested in

# Pull out the year, month, and day columns from the data
flights %>% select(year, month, day)

# You can use ":" to get a range of columns - try it with the above command
flights %>% select(year:day)

# "-" sign removes the column(s) - try removing the range of columns from above
flights %>% select(-(year:day))

# There are helper functions for the select() function:
# starts_with("abc")
# ends_with("xyz")
# contains("ijk")
# matches("(.)\\1") - regex
# num_ranges("x", 1:3) - expansion


# Use rename() function to rename a column:

# everything() is a shorthand for all the variables

# Exercises

################################################################################

# Use mutate() to add new variable(s)/column(s) based on existing columns

# We will be using a subset of the dataset:
flights_small  <- select(flights, year:day, ends_with("delay"), distance, air_time)

# Make new columns "gain" (dep_delay - arr_delay) and "speed" (distance / air_time * 60):

# Note that you can refer to the columns you've created in the mutate()
# function (as long as the column is declared before the specification).
#
# For example, you can create gain, hours (air_time / 60), and gain_per_hour
# (gain / hours) in a single command:

# mutate() keeps all the existing columns by default; if you only want the new
# columns, use transmute():

# Integer division (%/%) and modulo (%%) operation are worth noting

# Exercises


################################################################################

# Use summarise() to collapse/summarise data into a single row

# Find the mean value of dep_delay:

# Calculate the mean time the flight has been delayed for each day in the data:

# Explore the relationship between the distance and average delay for each
# location
#
# Pseudocode:
# 1. group flights by destination
# 2. summarise to compute distance, average delay, and number of flights
# 3. filter to remove noisy points (count > 20) and Honolulu airport, which is
#    almost twice as far away as the next closest airport
# 4. graph distance by delay, where point sizes show number of flights to the
#    destination, and also draw a smooth line to the points


################################################################################
# Chapter 7 - Exloratory data analysis












