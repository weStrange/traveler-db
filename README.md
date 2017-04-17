# traveler-db
## Short introduction on how to use it
to start the thing

`sudo docker run --name traveler-db -e POSTGRES_DB=traveler -P -p 5432:5432 -d alekster/traveler-db`

You might bump into a couple of issues

1) the port is already allocated

Solution: sudo kill \`sudo lsof -t -i:5432\`

2) Conflict: the name /traveler-db is already in use...

Solution: 

           sudo docker stop traveler-db
           sudo docker rm traveler-db
