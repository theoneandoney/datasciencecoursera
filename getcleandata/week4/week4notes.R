# | In this lesson, we'll explore the lubridate R package, by Garrett Grolemund and Hadley Wickham. According to the
# | package authors, "lubridate has a consistent, memorable syntax, that makes working with dates fun instead of
# | frustrating." If you've ever worked with dates in R, that statement probably has your attention.

Sys.getlocale("LC_TIME")

# | If the output above is not "en_US.UTF-8", you can change the locale used by R for the duration of this session
# | by typing Sys.setlocale("LC_TIME", "en_US.UTF-8"). Otherwise, this lesson is not guaranteed to work correctly.
# | We apologize for this inconvenience.

Sys.setlocale("LC_TIME", "en_US.UTF-8")

library(lubridate)

help(package = lubridate)

this_day <- today()
year(this_day)

# | Fortunately, lubridate offers a variety of functions for parsing date-times. These functions take the form of
# | ymd(), dmy(), hms(), ymd_hms(), etc., where each letter in the name of the function stands for the location of
# | years (y), months (m), days (d), hours (h), minutes (m), and/or seconds (s) in the date-time being read in.

now()
nyc <- now(tzone = "America/New_York")
depart <- nyc + days(2)
depart <- update(depart, hours = 17, minutes = 34)
arrive <- depart + hours(15) + minutes(50)
arrive <- with_tz(arrive, tzone="Asia/Hong_Kong")
last_time <- mdy("June 17, 2008", tz = "Singapore")
how_long <- interval(last_time, arrive)
as.period(how_long)


# | This is where things get a little tricky. Because of things like leap years, leap seconds, and daylight savings
# | time, the length of any given minute, day, month, week, or year is relative to when it occurs. In contrast, the
# | length of a second is always the same, regardless of when it occurs.
# | To address these complexities, the authors of lubridate introduce four classes of time related objects:
# | instants, intervals, durations, and periods. These topics are beyond the scope of this lesson, but you can find
# | a complete discussion in the 2011 Journal of Statistical Software paper titled 'Dates and Times Made Easy with
# | lubridate'.

