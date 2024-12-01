import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import time
from openai import OpenAI
client = OpenAI(api_key="OPEN AI API KEY")


# def text_generation(PROMPT, maxtokens=200):#generates text based response

    # response = client.completions.create(
    #     model="gpt-3.5-turbo-instruct",
    #     prompt=PROMPT,
    #     max_tokens=maxtokens
    # )
    # output = response.choices[0].text.strip()

    # return output



# Fetch the service account key JSON file path
cred = credentials.Certificate("credentials.json")  #change

# Initialize the Firebase app with the service account credentials    #change
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://mar10-89ff8-default-rtdb.firebaseio.com/'
})


# Reference to your Firebase database
refQ = db.reference('ChatBot/sendTextFromFlutterForChatBot/TextQuery')  #question  #change
refA = db.reference('ChatBot/receiveTextFromPythonForChatbot/QueryAnswer') #answer
while True:
 if refQ.get() != "":
    QueryText = refQ.get()
    print("Question : "+ QueryText)
    chat_gpt_answer = text_generation(QueryText)
    QueryAnswer = refA.set(chat_gpt_answer)
    refA1 = db.reference('ChatBot/receiveTextFromPythonForChatbot/QueryAnswer')  #answer
    QueryAnswer1 = refA1.get()
    print(QueryAnswer1)
    refQ = db.reference('ChatBot/sendTextFromFlutterForChatBot/TextQuery')  #question
    QueryText = refQ.set("")
 else:
     print("no data initilize")
 time.sleep(5)

