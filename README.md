README.md

This data set includes activities, subjects, and data. 30 people were tested on
6 different activities using a Samsung Galaxy S smartphone to find data using
the accelerometer and gyrometer.

My data set gives a mean for each value of the mean and standard deviation
measurements, for each activity-subject combination. This way, a clean data set
is generated which follows each of the principles of tidy data:

	Each variable forms a column
	Each observation forms a row
	Each type of observational unit forms a table
	
[https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html]

It then writes the tidy data set to a text file separated by tabs.

How it works:

Reads in the data using a mixture of delimiter and fixed-width format reading
techniques, using a variable "width" to provide lengths for the read_fwf
command succinctly.

Then the x, y, and subject data is merged for test and train data sets, then
the columns of the test and train data themselves.

I then added the labels from "features.txt", and filtered the data set such
that only measurements of means and standard deviations were present in the
data, stored in "filt".

Reading in the "activity_labels.txt", I used a for loop to replace each entry
in the "activity" column with its descriptive label, rather than leaving it as
a number. This is, in my opinion, much tidier.

I then used the dplyr package to group the activity and subjects, and taking
the mean of each column according to that group. This provides you with the
final tidy data set, which is written to a table.
