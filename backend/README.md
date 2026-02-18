To successfully install and run the JOT_WEBSITE_BACKEND on your machine or server


Before we begin installation, make sure:
•	Node.js and npm installed on the server.
•	You have access to install PostgreSQL (or it’s already installed).
•	You’ll run the backend with PM2, a Node.js process manager.
•	PostgreSQL database is on the same server (or accessible remotely).


Step 0: Copy/Clone from github the backend folder (judiciary-website-backend)
Step 1: Create a new dababase on postgres server and name it 'jot_web_db'
step 2: Restore database backup, use a database backup file located in 'judiciary-website-backend/database/backup.sql'  (to restore database run this command 'pg_dump -U your_db_user -h localhost -p 5432 -d your_db_name -F p -f backup.sql')

when database is setup, then follow steps below to run backend

step 3: Locate/change location and open backed folder (cd /home/your_user/judiciary-website-backend)
Step 4: Install node modules/dependencies by running "npm install" on your terminal 
Step 5: Create .env file inside the root folder (nano .env)
Step 6: Write/Copy below content in .env file created above;-
        <!-- NODE_ENV = DEVELOPMENT || yout node env
        PORT = 3000 Your node port
        SECRET_KEY = JoT_Website_Backend || || your_preferable_jwt_secretkey
        SUPER_ADMIN_EMAIL = weonjeo@gmail.com || your_preferable_super_user_email
        SUPER_ADMIN_PASSWORD = Muyula@123 || your_preferable_super_user_password
        MAIL_POST = 8083 || your_mail_service_api_port
        MAIL_HOST = http://196.192.79.209:8083/judiciary-gateway/api/v1/mail/sent-custom-mail || your mail_service_api_url
        FRONT_END_URL = http://localhost:3001 || your_front_end_url
        DB_DIALECT = postgres
        DB_HOST = localhost || your database server/host
        DB_PORT = 5432 || your database port
        DATABASE = jot_web_db || your_database_name
        DB_USER = postgres || your_database_user
        DB_PWD = Muyula@123 || your_database_password -->

Ignore step 7 and 8 if you have successfully restored the database as instructed in step 1 and 2

Step 7: Run migration command on your terminal this will create tables and views on your database <!-- npx sequelize-cli db:migrate  -->
Step 8: Run seeder command on your terminal <!-- npx sequelize-cli db:seed:all  -->

Step 9: Start backend using PM2
        - Open terminal and n navigate to backend folder (judiciary-website-backend)
        - Start backend with PM2 run <!-- pm2 start server.js --name jot-website-backend --> server.js → is the backend entry point file.
        - Check that It’s Running run <!-- pm2 list -->
        - <!-- pm2 save -->
        - <!-- pm2 startup -->
        

