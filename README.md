# DevOps Blog App

A Flask-based blog application demonstrating web development with Python, HTML, CSS, and Bootstrap.

---

## Application Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                    User Browser                                  │
│                  http://localhost:5000                           │
└────────────────────────┬────────────────────────────────────────┘
                         │
                    (1) Request
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                  Flask (app.py)                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │ @app.route("/")                                          │   │
│  │ def home():                                              │   │
│  │     return render_template("index.html",                │   │
│  │                            posts=blog_posts)            │   │
│  └──────────────────────────────────────────────────────────┘   │
└────────────────────────┬────────────────────────────────────────┘
                         │
              (2) Pass data to template
                         │
      ┌──────────────────┼──────────────────┐
      │                  │                  │
      ▼                  ▼                  ▼
┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│ index.html   │ │  style.css   │ │ bootstrap.css│
│ (Template)   │ │ (Custom CSS) │ │ (Framework)  │
└──────────────┘ └──────────────┘ └──────────────┘
      │                  │                  │
      └──────────────────┼──────────────────┘
                         │
              (3) Render HTML with CSS
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                  Rendered HTML Page                              │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ My DevOps Blog                                          │   │
│  │ ┌─────────────────────────────────────────────────────┐ │   │
│  │ │ Welcome to My DevOps Blog                           │ │   │
│  │ │ This is a demo blog post...                         │ │   │
│  │ └─────────────────────────────────────────────────────┘ │   │
│  │ ┌─────────────────────────────────────────────────────┐ │   │
│  │ │ Another Post                                        │ │   │
│  │ │ You can add more posts...                           │ │   │
│  │ └─────────────────────────────────────────────────────┘ │   │
│  └─────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

---

## Complete Flow

```
1. app = Flask(__name__)
   └─ App is created (happens when file is loaded)

2. app.run(...)
   └─ Server starts and waits on localhost:5000

3. User visits localhost:5000
   └─ Browser makes request to server

4. @app.route("/") matches the URL
   └─ Calls home() function

5. def home() executes:
   └─ Loads blog_posts data
   └─ Calls render_template("index.html", posts=blog_posts)

6. index.html receives posts variable
   └─ Jinja2 processes template
   └─ url_for() generates path to style.css
   └─ Loops through posts and inserts data
   └─ Generates final HTML

7. Browser receives final HTML
   └─ Applies Bootstrap CSS
   └─ Applies custom style.css
   └─ Displays styled blog page with post data
```

---

## Why Flask Needs the `app` Object

Everything in Flask requires the `app` object:

```python
app = Flask(__name__)         # Create the app

@app.route("/")               # Use app to define routes
def home():
    ...

app.run(...)                  # Use app to start server
```

---

## Project Structure

```
devops-blog-app/
├── app/
│   ├── app.py              # Flask application
│   ├── templates/
│   │   └── index.html      # HTML template
│   └── static/
│       └── style.css       # Custom CSS
├── Dockerfile              # Container configuration
└── requirements.txt        # Python dependencies
```

### File Descriptions

- **app.py** - Flask server, defines routes, loads blog data, starts the web server
- **index.html** - Web page template that displays blog posts using Jinja2
- **style.css** - Custom CSS styling for blog appearance (colors, shadows, fonts)
- **Dockerfile** - Configuration file for running the app in a Docker container
- **requirements.txt** - Python dependencies (Flask, etc.)

---

## Quick Start

1. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

2. **Run the application:**
   ```bash
   python app/app.py
   ```

3. **Access in browser:**
   ```
   http://localhost:5000
   ```

---

## Key Technologies

- **Flask** - Python web framework
- **Jinja2** - Template engine (built into Flask)
- **Bootstrap 5** - CSS framework for responsive design
- **Docker** - Container platform (optional)