# My Progress



My Progress is a personal progress-tracking web application built with Flutter and Serverpod.



The application allows users to organize their tracking into:



- **Topics**

- **Subtopics**

- **Fields**

- **Daily Logs**

- **Field Values**

- **Historical Reports**



The long-term goal is to make the application usable by multiple users, with each user's topics, logs, and tracking data kept private and isolated from other users.



---



## Project Structure



```text

my_progress/

│

├── my_progress_server/       # Serverpod backend, API endpoints, database configuration

├── my_progress_client/       # Generated Serverpod client

├── my_progress_flutter/      # Flutter web application

│

└── README.md                 # Project documentation

```



---



## Current Development Environment



The project currently uses:



- Flutter: **3.32.8**

- Dart: **3.8.1**

- Serverpod: **3.4.3**

- PostgreSQL

- Redis

- Docker / Docker Compose



### Important



The project is currently built around **Serverpod 3.4.3**.



Do **not** upgrade the project to Serverpod 4.x unless the application is intentionally migrated and tested.



---



# Running the Application Locally



The local application requires:



1\. Docker services

2\. Serverpod backend

3\. Flutter web build



## 1. Start Docker



From the project root:



```bash

cd "/Users/olasuaifan/Desktop/University/projects/Simple App/DailyTrackerApp/my_progress"

docker compose up -d

```



Check the containers:



```bash

docker ps

```



The PostgreSQL and Redis containers should be running.



---



## 2. Start Serverpod



Open another Terminal window:



```bash

cd "/Users/olasuaifan/Desktop/University/projects/Simple App/DailyTrackerApp/my_progress/my_progress_server"

dart bin/main.dart

```



If database migrations need to be applied:



```bash

dart bin/main.dart --apply-migrations

```



Keep this Terminal running while using the application.



### Local Server Ports



| Port | Purpose |

|---|---|

| 8080 | Serverpod API |

| 8081 | Serverpod server/internal services |

| 8082 | Web application |



If these ports are already occupied, an existing Serverpod process may already be running. Do not start a second Serverpod instance unnecessarily.



---



## 3. Build the Flutter Web Application



Open another Terminal window:



```bash

cd "/Users/olasuaifan/Desktop/University/projects/Simple App/DailyTrackerApp/my_progress/my_progress_flutter"

```



Build the web application:



```bash

flutter build web --base-href /app/ --no-tree-shake-icons --output ../my_progress_server/web/app

```



The generated Flutter web application is placed inside:



```text

my_progress_server/web/app

```



---



## 4. Open the Local Application



Open:



```text

http\://localhost:8082/app/

```



---



**# Docker Image Testing

The application has also been successfully tested as a Dockerized Serverpod application.

The Docker image is currently built for **local testing only**. It is not yet the production deployment image.

## Build the Docker Image

From the project root:

```bash
cd "/Users/olasuaifan/Desktop/University/projects/Simple App/DailyTrackerApp/my_progress"

docker build -f my_progress_server/Dockerfile -t my-progress-test .
```

## Run the Docker Test Container

The current local Docker test uses a temporary development configuration so that the container can connect to the PostgreSQL container on the Docker network.

```bash
docker run --rm   --name my-progress-container-test   --network my_progress_server_default   -p 9080:8080   -p 9081:8081   -p 9082:8082   -v /tmp/my_progress_development.yaml:/app/config/development.yaml:ro   --entrypoint /app/server   my-progress-test   --mode=development   --server-id=default   --logging=normal   --role=monolith
```

The Dockerized web application is available at:

```text
http://localhost:9082/app/
```

The Docker test currently uses:

- Serverpod **3.4.3**
- Dart **3.8.1**
- Flutter **3.32.8**
- PostgreSQL through the existing Docker network

## Flutter Web Build Note

The project previously used Flutter's `--wasm` web build. During Docker testing, the browser requested `main.dart.wasm`, but the generated application did not contain that file and Serverpod returned the HTML fallback with the wrong MIME type.

The verified working build therefore uses the standard Flutter Web build without `--wasm`:

```bash
flutter build web --base-href /app/ --no-tree-shake-icons --output ../my_progress_server/web/app
```

Do not add `--wasm` back unless the WebAssembly build and Serverpod web-file serving are intentionally re-tested.

## Docker Security Note

The current Docker setup still needs a production secret-management cleanup.

In particular:

```text
my_progress_server/config/passwords.yaml
```

contains sensitive local configuration and must **not** be committed to Git or baked into a public production Docker image.

Before publishing the Docker image or deploying publicly, the image/configuration must be changed so production secrets are supplied securely rather than copied into the image.

---

# Database / Docker**



The development environment uses PostgreSQL and Redis through Docker Compose.



The PostgreSQL database is used by Serverpod for application data and authentication data.



The development database is persistent through a Docker volume.



Do not place database passwords or other credentials in this README.



Sensitive configuration belongs in the appropriate local configuration files and must not be committed to Git.



---



# Authentication



The application uses Serverpod's authentication system with email/password authentication.



Authentication packages currently include:



```yaml

serverpod: 3.4.3

serverpod_auth_idp_server: 3.4.3

```



The server initializes:



- JWT authentication

- Email/password identity provider

- Registration verification

- Password reset verification



The Flutter application uses:



```text

FlutterAuthSessionManager

```



and checks whether the current user is authenticated before displaying the tracker.



---



# Registration and Password Reset



Registration and password reset verification codes are currently handled through Serverpod callbacks.



During development, the verification codes are written to the Serverpod server log.



This is intentional for local development.



## Important



Real email delivery has **not yet been implemented**.



Before public deployment, registration and password-reset verification codes must be sent through a proper email delivery service.



The verification codes must not be exposed through public application responses or production logs.



---



# User Data Ownership and Isolation



The application is designed so that each authenticated user owns their own tracker data.



The current authenticated user's Serverpod authentication identifier is used as the ownership identifier.



Topics contain:



```text

ownerUserIdentifier

```



New topics are automatically assigned to the currently authenticated user.



The server verifies ownership before allowing users to:



- View topics

- Create topics

- Update topics

- Delete topics

- View subtopics

- Create subtopics

- Update subtopics

- Delete subtopics

- View fields

- Create fields

- Update fields

- Delete fields

- Create daily logs

- View daily logs

- Save field values

- View field values



Ownership checks are performed on the **server side**.



The Flutter interface is not considered a security boundary.



A user should never be trusted merely because the Flutter application hides another user's data. The Serverpod endpoints must independently enforce ownership.



---



# Existing Security Work



The following security work has already been completed during development:



- Authentication was added to the application.

- Tracker endpoints require an authenticated user.

- Topic ownership was added.

- Existing topics were assigned to the original user.

- Subtopic operations verify ownership through the parent topic.

- Field operations verify ownership through the parent subtopic/topic.

- Daily log operations verify ownership.

- Field value operations verify ownership.

- Users cannot create tracker records under another user's topic.

- Delete operations perform ownership checks before modifying data.

- Sensitive local password configuration is excluded from Git.

- Old development credentials were removed from tracked test configuration.

- Local database backups are kept separately from normal source code.



---



# Authentication Testing



Two separate test accounts have been used during development to verify user isolation.



Testing confirmed that users can have separate tracker data and that server-side ownership checks prevent one account from intentionally accessing another account's tracker records.



Additional testing should still be performed using separate browser profiles/incognito sessions before public deployment.



Using two accounts in the same normal browser can be confusing because browser authentication/session storage can replace the currently active session.



The important security boundary is the server-side ownership enforcement.



---



# Backups



Local database backups have been created during development, including backups taken before ownership/security changes.



Backups should be kept outside Git whenever possible.



Do not commit:



- Database dumps

- Password files

- JWT secrets

- API keys

- Production credentials

- `.env` files containing secrets



---



# Migrations



Serverpod database migrations are stored in the server project.



A migration was created for adding topic ownership:



```text

20261022212841111-add-topic-owner

```



When changing database models:



1\. Update the Serverpod model.

2\. Generate/create the appropriate migration.

3\. Review the migration.

4\. Apply it locally.

5\. Test the application.

6\. Back up the database before important production migrations.



For local development, migrations can be applied with:



```bash

dart bin/main.dart --apply-migrations

```



---



# Sensitive Configuration



Sensitive configuration must never be placed in this README.



Never commit:



- Passwords

- Database credentials

- JWT secrets

- API keys

- Email service credentials

- Production environment variables

- Private certificates

- Private tokens



The file:



```text

my_progress_server/config/passwords.yaml

```



contains sensitive local configuration and must remain excluded from Git.



---



# Before Public Deployment



The application is **not considered production-ready yet**.



The following work should be completed before making the application publicly available.



## Authentication



- Implement real email delivery for registration verification.

- Implement real email delivery for password reset.

- Verify that verification codes are never exposed through production logs.

- Test registration from a clean browser.

- Test login/logout.

- Test password reset.

- Test invalid/expired verification codes.

- Test multiple simultaneous users.



## Data Security



- Complete ownership testing for every endpoint.

- Test unauthorized access attempts directly against the API.

- Verify that users cannot modify another user's records.

- Verify that users cannot delete another user's records.

- Verify cascading deletes do not affect another user's data.



## Production Configuration



- Generate production secrets.

- Rotate all development/test credentials that may have been exposed during development.

- Configure production database credentials securely.

- Configure production JWT/authentication secrets securely.

- Configure HTTPS.

- Configure secure production environment variables.

- Ensure debug/development configuration is not exposed publicly.



## Database



- Create reliable production backups.

- Test restoring a backup.

- Establish a database migration procedure.

- Protect the production database from public access.



## Hosting



- Deploy the Serverpod backend.

- Deploy the Flutter web application.

- Configure the production domain.

- Configure HTTPS.

- Verify API and web application routing.

- Test authentication from an external browser/device.



---



# Current Development Workflow



For normal local development:



### Terminal 1 — Docker



```bash

cd "/Users/olasuaifan/Desktop/University/projects/Simple App/DailyTrackerApp/my_progress"

docker compose up -d

```



### Terminal 2 — Serverpod



```bash

cd "/Users/olasuaifan/Desktop/University/projects/Simple App/DailyTrackerApp/my_progress/my_progress_server"

dart bin/main.dart

```



### Terminal 3 — Flutter Web



```bash

cd "/Users/olasuaifan/Desktop/University/projects/Simple App/DailyTrackerApp/my_progress/my_progress_flutter"

flutter build web --base-href /app/ --no-tree-shake-icons --output ../my_progress_server/web/app

```



### Browser



```text

http\://localhost:8082/app/

```



---



# Important Development Notes



- Keep Serverpod at **3.4.3** for the current project.

- Do not blindly upgrade dependencies while the application is stable.

- Make a backup before significant database/schema changes.

- Do not commit sensitive configuration.

- Server-side ownership checks are required even if the Flutter UI appears to hide another user's data.

- Keep the Serverpod terminal running while testing the local application.

- If ports 8080, 8081, or 8082 are already occupied, check whether the application is already running before starting another Serverpod process.



---



# Next Steps



The immediate development priorities are:



1\. Continue testing the application locally.

2\. Finish the historical logs/reporting functionality.

3\. Improve the timeline and graph functionality.

4\. Continue testing multi-user data isolation.

5\. Add real email verification.

6\. Complete production security configuration.

7\. Choose and configure production hosting.

8\. Perform a final production security test.

9\. Deploy the application publicly.



---



# Project Status



**Current stage:** Active development / local testing



The core tracker structure and authentication foundation are working.

The application has now been successfully built and run inside a Docker container using the existing Serverpod 3.4.3 and Flutter 3.32.8 versions. The Dockerized web application was verified locally at `http://localhost:9082/app/`.




Multi-user ownership/isolation has been implemented at the Serverpod endpoint level.



Production deployment should wait until authentication email delivery, production secrets, HTTPS, hosting configuration, backup/restore procedures, and comprehensive security testing are completed.