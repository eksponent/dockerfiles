# Eksponent Selenium+chromerunner+chrome

This is a selenium environment docker image with the follow versions locked in

- ChromeDriver 2.21.371459
- google-chrome-stable 52.0.2743.116
- selenium-server-standalone 2.49.1


We are using these versions because otherwise there are errors with newer configurations, such errors are

- Closing of media iframe doesnt allow further actions (context not found errors)


Upgrading from Chrome 52 to 53 will give errors like

`PHP Fatal error:  Call to a member function getParent() on null in features/bootstrap/CKEditorFeatureContext.php on line 15`

For CKEditor/WYSIWYG tests


### VNC Viewer

Make sure the ports are exposed from the hoster

```
    ports:
      - "5900:5900"
```


Connect and view, and your favourite VNC viewer at the IP of the container

Use `docker inspect TheName` to find the IP

`gvncviewer 172.20.0.5`
