import cv2
from PIL import Image
import os
import pyttsx3
from moviepy.editor import VideoFileClip, AudioFileClip
class img2vvideo:
 def img_to_video(self):
  os.chdir("M:/login_page_official/new_in_tamil/VideoSenderReceiver/images")
  path=os.getcwd()
  #os.remove("D:\output\fun.avi")
  video_output_path="M:/login_page_official/new_in_tamil//VideoSenderReceiver/video"
  video_name="fun.avi"
  video_output_fullpath=os.path.join(video_output_path,video_name)
  images_name=os.listdir()
  imges=[]
  for i in images_name:
    g=os.path.join(path,i)
    imges.append(g)
  im_obj=cv2.imread(imges[0])
  height,width=im_obj.shape[:2]
  tuple1=(width,height)
  print((height,width))
#fourcc = cv2.VideoWriter_fourcc(*'mp4v')
  video=cv2.VideoWriter(video_output_fullpath,0,0.1,tuple1)
  for i in  imges:
    video.write(cv2.imread(i))
  video.release()


