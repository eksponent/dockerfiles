# Eksponent Selenium+chromerunner+chrome

This is a selenium environment docker image with the follow versions locked in

- ChromeDriver 2.21.371459
- google-chrome-stable 52.0.2743.116
- selenium-server-standalone 2.49.1


We are using these versions because otherwise there are errors with newer configurations, such errors are

- Closing of media iframe doesnt allow further actions (context not found errors)
