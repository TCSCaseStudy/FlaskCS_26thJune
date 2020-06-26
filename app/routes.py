from app import app

@app.route("/")
@app.route("/index",methods=['GET','POST'])
def index():
	return "<h1>Hello World</h1>"

@app.route("/login",methods=['GET','POST'])
def login():
    pass

# Add methods here
# # New changes coming soon