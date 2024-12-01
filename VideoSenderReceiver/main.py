
import time
import firebase_admin
from firebase_admin import credentials, storage, db
import image_to_video as gg
import os

from openai import OpenAI
import cv2
import numpy as np
import requests
import pyttsx3
from moviepy.editor import VideoFileClip, AudioFileClip


# client = OpenAI(api_key="OPEN AI API KEY")
# def text_generation(PROMPT, maxtokens=200):#generates text based response

#     response = client.completions.create(
#         model="gpt-3.5-turbo-instruct",
#         prompt=PROMPT,
#         max_tokens=maxtokens
#     )
#     output = response.choices[0].text.strip()

#     return output
def imgtext_generation(PROMPT, maxtokens=170):#genarates prompt for genarating images
    # Generate completion
    response = client.completions.create(
        model="gpt-3.5-turbo-instruct",
        prompt=PROMPT+"(based on the text specified   give me a prompt to generate related images(only reply prompt that generate images make it easy) ) ",
        max_tokens=maxtokens
    )
    imgoutput = response.choices[0].text.strip()
    return imgoutput

def image_creation(PROMPT, no_of_img=5):#genarates images
    image_urls = []
    response = client.images.generate(
        model="dall-e-2",
        prompt=PROMPT,
        size="1024x1024",
        quality="standard",
        n=no_of_img
    )
    for data in response.data:
        image_urls.append(data.url)
    return image_urls
def img_to_url(url):#gets images from url

        for idx, image_url in enumerate(image_urls):
            # Fetch the image from the URL
            response = requests.get(image_url)

            # Check if the request was successful
            if response.status_code == 200:
                # Decode the image content
                image_data = response.content

                # Convert the image data into a NumPy array
                np_array = np.frombuffer(image_data, np.uint8)

                # Decode the NumPy array into an OpenCV image object
                opencv_image = cv2.imdecode(np_array, cv2.IMREAD_COLOR)

                # Save the image
                name = f"image_{idx}.jpg"
                cv2.imwrite(f"M:/login_page_official/new_in_tamil/VideoSenderReceiver/images/{name}", opencv_image)

                # Display the image
                #cv2.imshow("Image", opencv_image)
                cv2.waitKey(0)

        # Close all OpenCV windows
        cv2.destroyAllWindows()
def text_to_speech(text, output_file):# generates speech
    # Initialize the text-to-speech engine
    engine = pyttsx3.init()
    engine.setProperty("speed",100)

    # Save the speech as an audio file
    engine.save_to_file(text, output_file)
    engine.runAndWait()
def merge_audio_video(video_file, audio_file, output_file):#mearges audio and video file
    # Load the video clip
    video_clip = VideoFileClip(video_file)

    # Load the audio clip
    audio_clip = AudioFileClip(audio_file)

    # Set the audio of the video clip to the loaded audio clip

    if audio_clip.duration > video_clip.duration:
        audio_clip = audio_clip.subclip(0, video_clip.duration)
    elif audio_clip.duration < video_clip.duration:
        video_clip = video_clip.subclip(0, audio_clip.duration)
    video_clip = video_clip.set_audio(audio_clip)

    # Write the merged video file
    video_clip.write_videofile(output_file, codec="libx264", audio_codec="aac")
    #video_clip.show()

# Initialize Firebase Admin SDK
cred = credentials.Certificate("credentials.json")
firebase_admin.initialize_app(cred, {'storageBucket': 'your storage firebase link','databaseURL': 'database url'})


refQ = db.reference('Video/SendQueryFromFlutter/Question')
while True:
 if refQ.get() != "":
        QueryText = refQ.get()
        # input for video generator code --- > QueryText
        print("Question : ", QueryText)

        userprompt = QueryText
        text_response = text_generation(userprompt) #text based on query
        print(text_response)
        img_prompt = imgtext_generation(text_response) # generate image prompt
        print(img_prompt)

        image_urls = image_creation(img_prompt, 5) # gets img from url
        print(image_urls)
        img_to_url(image_urls)
        img_to_videoobj = gg.img2vvideo()
        img_to_videoobj.img_to_video()
        text_to_speech(text_response, "M:/login_page_official/new_in_tamil/VideoSenderReceiver/audio/output_audio.mp3")
        merge_audio_video("M:/login_page_official/new_in_tamil/VideoSenderReceiver/video/fun.avi", "M:/login_page_official/new_in_tamil/VideoSenderReceiver/audio/output_audio.mp3", "M:/login_page_official/new_in_tamil/VideoSenderReceiver/videoaudio/fish.mp4")

        #.sleep(5)  #take it after
        #for firebase storage
        bucket = firebase_admin.storage.bucket()

        # Path to the local file you want to upload
        local_file_path = "M:/login_page_official/new_in_tamil/VideoSenderReceiver/videoaudio/fish.mp4"

        # Destination path in Firebase Storage
        destination_blob_name = "test/fish.mp4"

        # Upload the local file to Firebase Storage
        blob = bucket.blob(destination_blob_name)
        blob.upload_from_filename(local_file_path)

        print("File uploaded to Firebase Storage.")

        refQ = db.reference('Video/SendQueryFromFlutter/Question')
        QueryText = refQ.set("")
 else:
     print("no data initialized")
 time.sleep(5)
