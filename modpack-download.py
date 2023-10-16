import requests
import json

search_query = input("Enter the modpack to find: ")
formatted_search_query = search_query.replace(" ", "+")

url = f"https://www.curseforge.com/api/v1/mods/search?gameId=432&index=0&classId=4471&filterText={formatted_search_query}&pageSize=20&sortField=2"
response = requests.get(url)
response_data = response.json()['data']

for item in response_data:
    print(f"{item['name']} - {item['author']['name']}")
    print(f"{item['websiteRecentFiles'][1]['files'][0]['fileName']}")
    print("\n\n")
