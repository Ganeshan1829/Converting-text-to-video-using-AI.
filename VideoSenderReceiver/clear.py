import os
l=["M:/connection test/VideoSenderReceiver/video/fun.avi","M:/connection test/VideoSenderReceiver/videoaudio/fish.mp4"]
os.chdir("M:/connection test/VideoSenderReceiver")
for i in l:
  os.remove(l)

os.chdir("M:/connection test/VideoSenderReceiver/images")
listofimagename=os.listdir("M:/connection test/VideoSenderReceiver/images")

for i in listofimagename:
     path="M:/connection test/VideoSenderReceiver/images"
     for j in listofimagename:
        file_with_img=os.path.join(j)
        os.remove(file_with_img)

