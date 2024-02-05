from flask import Flask, request
import os

app = Flask(__name__)


# Intentional vulnerability: Insecure use of eval()
@app.route("/eval")
def index():
    return str(eval(request.args.get("input", "")))


# Outdated dependency usage and intentional error
# Note: You should have an older Flask version specified in requirements.txt
@app.route("/hello")
def hello():
    # Intentional coding error: Undefined variable 'name' used
    return "Hello " + name


if __name__ == "__main__":
    app.run(debug=True)
