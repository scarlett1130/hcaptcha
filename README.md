Integrate hCaptcha into your Flutter App without any dependency.
  
## Getting started
Use pub to install package
  
```
flutter pub add hcaptcha
```
  
Now initialize hCaptcha using

```dart
HCaptcha.init(initialSite: 'https://YOUR-SITE.com/path-to-captcha.html');
// OR
HCaptcha.init(siteKey: 'YOUR-SITE-KEY');
```
  
If you use initialSite then provide link to a html file with content

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Captcha Challenge</title>
    </head>

    <body>
        <div style="display: flex; justify-content: center;">
            <form method="POST">
                <div class="h-captcha" data-sitekey="YOUR_SECRET_GOES_HERE" data-callback="captchaCallback"></div>
                <script src="https://js.hcaptcha.com/1/api.js" async defer></script>
            </form>
        </div>

        <script>
            function captchaCallback(response) {
                if (typeof Captcha!=="undefined") {
                    Captcha.postMessage(response);
                }
            }
        </script>
    </body>
</html>
```

## Usage
Inside your form, add the captcha logic when submitting:

```dart
if (_formKey.currentState!.validate()) {
    Map? captchaDetails = await HCaptcha.show(context);

    // validated
    if (captchaDetails != null) {
        // now use captchaDetails['code']
    }
}
```
