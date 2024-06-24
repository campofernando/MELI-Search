# MELI-Search
iOS App for demonstrating how to search items using MercadoLivre API

# How it works
The app starts loading the items of a "favorite" category, in this case antiquities. When the user enters a text for search, the app redirects him to a new list with the results for his search. In both lists the user can click on any item for seeing details of the product, i.e.: the price, an image and a description.

# TODO:
### Bugfixes:
- Improve the way the images are loades on the lists. Instead of loading each image per card, download all images, and then show the view.
- Improve the use of persistence. Check for items and images locally before downloading.

### Features:
- Keep record of last searches: Every search could be saved locally on the database. When user starts searching the app will show similar search strings
- Show previously searched items and previously viewed: Separate the home view in three horizontal stacks where the app will sho the items of the favourite category, previously viewd items and previously searched items. This will also require persistence.
