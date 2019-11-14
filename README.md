# Recipies
Recipes is a Django application that allows tagging of arbitrary numbers of recipes (or in fact any other file) in a storage backend.
It also allows the easy creation of recipes directly on the page.
Currently the only supported storage backend is dropbox, but this can easily be changed as the system is modular and 
already has fields to support different backends.

## Usage
Most things should be straight forward but there are some more complicated things.
##### General
Different kinds of objects, like tags or storage backends, can be viewed under the lists tab. This is also were you create
new objects by pressing the plus button.
Management options for your data, like batch edits and import logs, can be found under `Manage Data`.
##### Storage Backends
Currently only dropbox is supported as a storage backend. To add a new Dropbox go to `Lists >> Storage Backend` and add a new backend. 
Enter a name (just a display name for you to identify it) and an API access Token for the account you want to use.
You can obtain the API token on [Dropboxes API explorer](https://dropbox.github.io/dropbox-api-v2-explorer/#auth_token/from_oauth1)
with the button on the top right.
##### Adding Synced Path's
To add a new path from your Storage backend to the sync list, go to `Manage Data >> Configure Sync` and select the storage backend you want to use.
Then enter the path you want to monitor starting at the storage root (e.g. `/Folder/RecipesFolder`) and save it.
##### Syncing Data
To sync the recipes app with the storage backends press `Sync now` under `Manage Data >> Configure Sync`.
##### Import Recipes
All files found by the sync can be found under `Manage Data >> Import recipes`. There you can either import all at once without
modifying them or import one by one, adding Category and Tags while importing.
##### Batch Edit
If you have many untagged recipes you may want to edit them all at once. For this go to
`Manage Data >> Batch Edit`. Enter a word which should be contained in the recipe name and select the tags you want to apply.
When clicking submit every recipe containing the word will be updated (tags are added).

> Currently the only option is word contains, maybe some more SQL like operators will be added later.

## Installation

### Docker-Compose
A docker-compose file is included in the repository. It is made for setups already running an nginx-reverse proxy network with 
lets encrypt companion. Copy `.env.template` to `.env` and fill in the missing values accordingly.  
Now simply start the containers and run the `update.sh` script which will apply all migrations and collect static files.
Create a default user by executing into the container with `docker-compose exec web_recipes sh` and run `python3 manage.py createsuperuser`.

### Manual
Copy `.env.template` to `.env` and fill in the missing values accordingly.  
You can leave out the docker specific variables (VIRTUAL_HOST, LETSENCRYPT_HOST, LETSENCRYPT_EMAIL). 
Make sure all variables are available to whatever servers your application.

Otherwise simply follow the instructions for any django based deployment
(for example this one http://uwsgi-docs.readthedocs.io/en/latest/tutorials/Django_and_nginx.html).

To start developing:
1. Clone the repository using your preferred method
2. Install requirements from `requirements.txt` either globally or in a virtual environment
3. Run migrations with `manage.py migrate`
4. Create a first user with `manage.py createsuperuser`
5. Start development server with `manage.py runserver`

## Contributing
Pull Requests and ideas are welcome, feel free to contribute in any way.

## License
This project is licensed under the MIT license. Even though it is not required to publish derivatives i highly encourage
pushing changes upstream and letting people profit from any work done on this project.