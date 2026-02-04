from flask import Flask, render_template
import os

app = Flask(__name__)

# Load secret key from environment (demonstrates use of secrets)
app.secret_key = os.environ.get("SECRET_KEY", "devops-demo-key")

# Simple one-page blog content
blog_posts = [
    {
        "title": "Welcome to My DevOps Blog",
        "content": "This is a demo blog post running in a containerized Flask app!"
    },
    {
        "title": "Another Post",
        "content": "You can add more posts here if you want."
    }
]

@app.route("/")
def home():
    return render_template("index.html", posts=blog_posts)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
