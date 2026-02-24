# Odin Project: Unsplash API

A simple photo viewer that retrieves public collection photos using the [Unsplash](https://unsplash.com/) API.

All svg icons were provided by [Pictogrammers](https://pictogrammers.com/).

## Dependencies

- [Ruby](https://www.ruby-lang.org/en/)

## Usage

```
git clone https://github.com/norkitorki/odin-project-unsplash-api.git &&
cd odin-project-unsplash-api &&
bundle install &&
bundle exec figaro install
```

[Create](https://unsplash.com/join) or [Sign](https://unsplash.com/login) in to your account and register a demo application.

Open config/application.yml in your favorite text editor and add your unsplash access key:

```
# Replace <YOUR_ACCESS_KEY> with your own valid access key
unsplash_key: <YOUR_ACCESS_KEY>
```

Now you can run the application via:

```
bin/dev
```

Open your preferred web browser and visit http://127.0.0.1:3000/ to use the application

## Screenshots

![Home Screenshot](../screenshots/home.png?raw=true)
![Photo Viewer Screenshot](../screenshots/photo_viewer.png?raw=true)
