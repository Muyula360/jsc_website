# React + Vite

To successfully install and run website frontend on your machine or server

Before we begin installation, make sure:
•	Node.js and npm installed on the server.
•	frontend will be served using NGINX.


Step 0: Locate the frontend folder (judiciary-website-frontend) and open it in terminal
Step 1: Install node modules by running "npm install" on your terminal 
Step 2: create .env file inside the root folder and write in content as below;-
    <!-- VITE_API_WEBMEDIAURL = http://localhost:3000 || replace your backend  url
    VITE_API_WEBURL = http://localhost:3001 || replace your front end url -->

Step 3: Run "npm run build" to build frontend (this will create a 'dist' folder)
Step 4: Copy dist folder to the following location 'var/www/html/'
Step 5: Edit the NGINX default Configurations run <!-- sudo nano /etc/nginx/sites-available/default -->
        basic frontend configurations on NGINX 
        <!-- 
        server {
            listen 80;
            server_name _;
            root /var/www/html;
            index index.html;
            #Serve static files for Vite (React) build
            location / {
                try_files $uri /index.html;
            }
            #Proxy API requests to Node.js backend
            location /api/ {
                proxy_pass http://localhost:3000/;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host $host;
                proxy_cache_bypass $http_upgrade;
            }
            #Proxy HRMIS server requests
            location /jahrm-connect/ {
                proxy_pass http://192.168.1.159:8090/;
                proxy_http_version 1.1;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            }
            # Optional: Prevent access to hidden files like .env
            location ~ /\. {
                deny all;
            }
        }
        -->

Step 6: Test NGINX Configuration <!-- sudo nginx -t -->
Step 7: Restart NGINX to Apply Changes <!-- sudo systemctl restart nginx -->