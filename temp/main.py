
from bs4 import BeautifulSoup
import requests
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate(
    "./unifynd-hoth-firebase-adminsdk-gzyt1-b44d0dd915 (1).json")
firebase_admin.initialize_app(cred)

# make function that publishes a document to firestore

db = firestore.client()

# make function that publishes a document to firestore


def publish_to_firestore(collection, document, data):
    db.collection(collection).document(document).set(data)


# boilerplate for webscraper


# url of the website to scrape

url = 'httpsgoogle.com'

# request the url

r = requests.get("https://menu.dining.ucla.edu/")

# parse the htm
# find all p tags in the id main-content

soup = BeautifulSoup(r.text, 'html.parser')

# Find all the divs with class "content-block"
content_blocks = soup.find_all('div', class_='content-block')

# Loop through each content block
for block in content_blocks:
    try:
        # Extract the heading
        heading = block.find('h3').text

        # Find all the paragraphs with restaurant information
        restaurants = block.find_all('p')

        # Loop through each restaurant
        for restaurant in restaurants:
            # Extract the name and activity level
            name = restaurant.find('span', class_='unit-name').text
            link = restaurant.find('a').get('href')
            activity = restaurant.find(
                'span', class_='activity-level').get('class')[1]

            # Print the restaurant name and activity level
            print(f"{name}: {activity.split('-')[-1]}, link: {link}")

            publish_to_firestore("restaurants", name, {"activity": int(
                activity.split('-')[-1]), "link": "https://menu.dining.ucla.edu"+link, "name": name})

        print()  # Add a blank line after each section
    except:
        pass
