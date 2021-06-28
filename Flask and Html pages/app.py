from keras.models import load_model
from flask import Flask, render_template, request, current_app 
import joblib
from PIL import Image
import numpy as np
from keras.preprocessing import image

app = Flask("BrainTumorApp")
from tensorflow import keras
model = keras.models.load_model("brain_tumor_40.h5")


@app.route("/brain_tumor")
def home():
   return render_template("myform.html")
@app.route("/prediction", methods=['POST'] )
def brain_tumor():
    x1 = request.files['img']
    x1.save("brain.jpg")
    test_image = image.load_img("brain.jpg", target_size = (64, 64))
    test_image = image.img_to_array(test_image)
    test_image = np.expand_dims(test_image, axis = 0)
    result = model.predict(test_image)
    if str(round(result[0][0])) == 0:
        data="Glioma Tumor Detected"
        return render_template("results.html", data=data)
    elif str(round(result[0][1])) == 1:
        data="Meningioma Tumor Detected"
        return render_template("results.html", data=data)
    if str(round(result[0][2])) == 2:
        data="No Tumor Detected"
        return render_template("results.html", data=data)
    else:   
        data="Pituitary Tumor Detected"
        return render_template("results.html", data=data)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=4444)

